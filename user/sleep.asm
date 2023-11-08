
user/_sleep：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *args[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  if (argc < 2)
   a:	4785                	li	a5,1
   c:	02a7db63          	bge	a5,a0,42 <main+0x42>
  {
    printf("Usage: %s <argument>\n", args[0]);
    return -1;
  }

  int n = atoi(args[1]);
  10:	6588                	ld	a0,8(a1)
  12:	00000097          	auipc	ra,0x0
  16:	1b8080e7          	jalr	440(ra) # 1ca <atoi>
  1a:	84aa                	mv	s1,a0
  sleep(n);
  1c:	00000097          	auipc	ra,0x0
  20:	338080e7          	jalr	824(ra) # 354 <sleep>
  printf("sleeping seconds: %d \n", n);
  24:	85a6                	mv	a1,s1
  26:	00000517          	auipc	a0,0x0
  2a:	7d250513          	addi	a0,a0,2002 # 7f8 <malloc+0x102>
  2e:	00000097          	auipc	ra,0x0
  32:	610080e7          	jalr	1552(ra) # 63e <printf>

  return 0;
  36:	4501                	li	a0,0
}
  38:	60e2                	ld	ra,24(sp)
  3a:	6442                	ld	s0,16(sp)
  3c:	64a2                	ld	s1,8(sp)
  3e:	6105                	addi	sp,sp,32
  40:	8082                	ret
    printf("Usage: %s <argument>\n", args[0]);
  42:	618c                	ld	a1,0(a1)
  44:	00000517          	auipc	a0,0x0
  48:	79c50513          	addi	a0,a0,1948 # 7e0 <malloc+0xea>
  4c:	00000097          	auipc	ra,0x0
  50:	5f2080e7          	jalr	1522(ra) # 63e <printf>
    return -1;
  54:	557d                	li	a0,-1
  56:	b7cd                	j	38 <main+0x38>

0000000000000058 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  58:	1141                	addi	sp,sp,-16
  5a:	e422                	sd	s0,8(sp)
  5c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  5e:	87aa                	mv	a5,a0
  60:	0585                	addi	a1,a1,1
  62:	0785                	addi	a5,a5,1
  64:	fff5c703          	lbu	a4,-1(a1)
  68:	fee78fa3          	sb	a4,-1(a5)
  6c:	fb75                	bnez	a4,60 <strcpy+0x8>
    ;
  return os;
}
  6e:	6422                	ld	s0,8(sp)
  70:	0141                	addi	sp,sp,16
  72:	8082                	ret

0000000000000074 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  74:	1141                	addi	sp,sp,-16
  76:	e422                	sd	s0,8(sp)
  78:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  7a:	00054783          	lbu	a5,0(a0)
  7e:	cb91                	beqz	a5,92 <strcmp+0x1e>
  80:	0005c703          	lbu	a4,0(a1)
  84:	00f71763          	bne	a4,a5,92 <strcmp+0x1e>
    p++, q++;
  88:	0505                	addi	a0,a0,1
  8a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  8c:	00054783          	lbu	a5,0(a0)
  90:	fbe5                	bnez	a5,80 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  92:	0005c503          	lbu	a0,0(a1)
}
  96:	40a7853b          	subw	a0,a5,a0
  9a:	6422                	ld	s0,8(sp)
  9c:	0141                	addi	sp,sp,16
  9e:	8082                	ret

00000000000000a0 <strlen>:

uint
strlen(const char *s)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  a6:	00054783          	lbu	a5,0(a0)
  aa:	cf91                	beqz	a5,c6 <strlen+0x26>
  ac:	0505                	addi	a0,a0,1
  ae:	87aa                	mv	a5,a0
  b0:	4685                	li	a3,1
  b2:	9e89                	subw	a3,a3,a0
  b4:	00f6853b          	addw	a0,a3,a5
  b8:	0785                	addi	a5,a5,1
  ba:	fff7c703          	lbu	a4,-1(a5)
  be:	fb7d                	bnez	a4,b4 <strlen+0x14>
    ;
  return n;
}
  c0:	6422                	ld	s0,8(sp)
  c2:	0141                	addi	sp,sp,16
  c4:	8082                	ret
  for(n = 0; s[n]; n++)
  c6:	4501                	li	a0,0
  c8:	bfe5                	j	c0 <strlen+0x20>

00000000000000ca <memset>:

void*
memset(void *dst, int c, uint n)
{
  ca:	1141                	addi	sp,sp,-16
  cc:	e422                	sd	s0,8(sp)
  ce:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d0:	ca19                	beqz	a2,e6 <memset+0x1c>
  d2:	87aa                	mv	a5,a0
  d4:	1602                	slli	a2,a2,0x20
  d6:	9201                	srli	a2,a2,0x20
  d8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  dc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  e0:	0785                	addi	a5,a5,1
  e2:	fee79de3          	bne	a5,a4,dc <memset+0x12>
  }
  return dst;
}
  e6:	6422                	ld	s0,8(sp)
  e8:	0141                	addi	sp,sp,16
  ea:	8082                	ret

00000000000000ec <strchr>:

char*
strchr(const char *s, char c)
{
  ec:	1141                	addi	sp,sp,-16
  ee:	e422                	sd	s0,8(sp)
  f0:	0800                	addi	s0,sp,16
  for(; *s; s++)
  f2:	00054783          	lbu	a5,0(a0)
  f6:	cb99                	beqz	a5,10c <strchr+0x20>
    if(*s == c)
  f8:	00f58763          	beq	a1,a5,106 <strchr+0x1a>
  for(; *s; s++)
  fc:	0505                	addi	a0,a0,1
  fe:	00054783          	lbu	a5,0(a0)
 102:	fbfd                	bnez	a5,f8 <strchr+0xc>
      return (char*)s;
  return 0;
 104:	4501                	li	a0,0
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	addi	sp,sp,16
 10a:	8082                	ret
  return 0;
 10c:	4501                	li	a0,0
 10e:	bfe5                	j	106 <strchr+0x1a>

0000000000000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	711d                	addi	sp,sp,-96
 112:	ec86                	sd	ra,88(sp)
 114:	e8a2                	sd	s0,80(sp)
 116:	e4a6                	sd	s1,72(sp)
 118:	e0ca                	sd	s2,64(sp)
 11a:	fc4e                	sd	s3,56(sp)
 11c:	f852                	sd	s4,48(sp)
 11e:	f456                	sd	s5,40(sp)
 120:	f05a                	sd	s6,32(sp)
 122:	ec5e                	sd	s7,24(sp)
 124:	1080                	addi	s0,sp,96
 126:	8baa                	mv	s7,a0
 128:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12a:	892a                	mv	s2,a0
 12c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 12e:	4aa9                	li	s5,10
 130:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 132:	89a6                	mv	s3,s1
 134:	2485                	addiw	s1,s1,1
 136:	0344d863          	bge	s1,s4,166 <gets+0x56>
    cc = read(0, &c, 1);
 13a:	4605                	li	a2,1
 13c:	faf40593          	addi	a1,s0,-81
 140:	4501                	li	a0,0
 142:	00000097          	auipc	ra,0x0
 146:	19a080e7          	jalr	410(ra) # 2dc <read>
    if(cc < 1)
 14a:	00a05e63          	blez	a0,166 <gets+0x56>
    buf[i++] = c;
 14e:	faf44783          	lbu	a5,-81(s0)
 152:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 156:	01578763          	beq	a5,s5,164 <gets+0x54>
 15a:	0905                	addi	s2,s2,1
 15c:	fd679be3          	bne	a5,s6,132 <gets+0x22>
  for(i=0; i+1 < max; ){
 160:	89a6                	mv	s3,s1
 162:	a011                	j	166 <gets+0x56>
 164:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 166:	99de                	add	s3,s3,s7
 168:	00098023          	sb	zero,0(s3)
  return buf;
}
 16c:	855e                	mv	a0,s7
 16e:	60e6                	ld	ra,88(sp)
 170:	6446                	ld	s0,80(sp)
 172:	64a6                	ld	s1,72(sp)
 174:	6906                	ld	s2,64(sp)
 176:	79e2                	ld	s3,56(sp)
 178:	7a42                	ld	s4,48(sp)
 17a:	7aa2                	ld	s5,40(sp)
 17c:	7b02                	ld	s6,32(sp)
 17e:	6be2                	ld	s7,24(sp)
 180:	6125                	addi	sp,sp,96
 182:	8082                	ret

0000000000000184 <stat>:

int
stat(const char *n, struct stat *st)
{
 184:	1101                	addi	sp,sp,-32
 186:	ec06                	sd	ra,24(sp)
 188:	e822                	sd	s0,16(sp)
 18a:	e426                	sd	s1,8(sp)
 18c:	e04a                	sd	s2,0(sp)
 18e:	1000                	addi	s0,sp,32
 190:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 192:	4581                	li	a1,0
 194:	00000097          	auipc	ra,0x0
 198:	170080e7          	jalr	368(ra) # 304 <open>
  if(fd < 0)
 19c:	02054563          	bltz	a0,1c6 <stat+0x42>
 1a0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a2:	85ca                	mv	a1,s2
 1a4:	00000097          	auipc	ra,0x0
 1a8:	178080e7          	jalr	376(ra) # 31c <fstat>
 1ac:	892a                	mv	s2,a0
  close(fd);
 1ae:	8526                	mv	a0,s1
 1b0:	00000097          	auipc	ra,0x0
 1b4:	13c080e7          	jalr	316(ra) # 2ec <close>
  return r;
}
 1b8:	854a                	mv	a0,s2
 1ba:	60e2                	ld	ra,24(sp)
 1bc:	6442                	ld	s0,16(sp)
 1be:	64a2                	ld	s1,8(sp)
 1c0:	6902                	ld	s2,0(sp)
 1c2:	6105                	addi	sp,sp,32
 1c4:	8082                	ret
    return -1;
 1c6:	597d                	li	s2,-1
 1c8:	bfc5                	j	1b8 <stat+0x34>

00000000000001ca <atoi>:

int
atoi(const char *s)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d0:	00054683          	lbu	a3,0(a0)
 1d4:	fd06879b          	addiw	a5,a3,-48
 1d8:	0ff7f793          	zext.b	a5,a5
 1dc:	4625                	li	a2,9
 1de:	02f66863          	bltu	a2,a5,20e <atoi+0x44>
 1e2:	872a                	mv	a4,a0
  n = 0;
 1e4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1e6:	0705                	addi	a4,a4,1
 1e8:	0025179b          	slliw	a5,a0,0x2
 1ec:	9fa9                	addw	a5,a5,a0
 1ee:	0017979b          	slliw	a5,a5,0x1
 1f2:	9fb5                	addw	a5,a5,a3
 1f4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f8:	00074683          	lbu	a3,0(a4)
 1fc:	fd06879b          	addiw	a5,a3,-48
 200:	0ff7f793          	zext.b	a5,a5
 204:	fef671e3          	bgeu	a2,a5,1e6 <atoi+0x1c>
  return n;
}
 208:	6422                	ld	s0,8(sp)
 20a:	0141                	addi	sp,sp,16
 20c:	8082                	ret
  n = 0;
 20e:	4501                	li	a0,0
 210:	bfe5                	j	208 <atoi+0x3e>

0000000000000212 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 212:	1141                	addi	sp,sp,-16
 214:	e422                	sd	s0,8(sp)
 216:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 218:	02b57463          	bgeu	a0,a1,240 <memmove+0x2e>
    while(n-- > 0)
 21c:	00c05f63          	blez	a2,23a <memmove+0x28>
 220:	1602                	slli	a2,a2,0x20
 222:	9201                	srli	a2,a2,0x20
 224:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 228:	872a                	mv	a4,a0
      *dst++ = *src++;
 22a:	0585                	addi	a1,a1,1
 22c:	0705                	addi	a4,a4,1
 22e:	fff5c683          	lbu	a3,-1(a1)
 232:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 236:	fee79ae3          	bne	a5,a4,22a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 23a:	6422                	ld	s0,8(sp)
 23c:	0141                	addi	sp,sp,16
 23e:	8082                	ret
    dst += n;
 240:	00c50733          	add	a4,a0,a2
    src += n;
 244:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 246:	fec05ae3          	blez	a2,23a <memmove+0x28>
 24a:	fff6079b          	addiw	a5,a2,-1
 24e:	1782                	slli	a5,a5,0x20
 250:	9381                	srli	a5,a5,0x20
 252:	fff7c793          	not	a5,a5
 256:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 258:	15fd                	addi	a1,a1,-1
 25a:	177d                	addi	a4,a4,-1
 25c:	0005c683          	lbu	a3,0(a1)
 260:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 264:	fee79ae3          	bne	a5,a4,258 <memmove+0x46>
 268:	bfc9                	j	23a <memmove+0x28>

000000000000026a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e422                	sd	s0,8(sp)
 26e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 270:	ca05                	beqz	a2,2a0 <memcmp+0x36>
 272:	fff6069b          	addiw	a3,a2,-1
 276:	1682                	slli	a3,a3,0x20
 278:	9281                	srli	a3,a3,0x20
 27a:	0685                	addi	a3,a3,1
 27c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 27e:	00054783          	lbu	a5,0(a0)
 282:	0005c703          	lbu	a4,0(a1)
 286:	00e79863          	bne	a5,a4,296 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 28a:	0505                	addi	a0,a0,1
    p2++;
 28c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 28e:	fed518e3          	bne	a0,a3,27e <memcmp+0x14>
  }
  return 0;
 292:	4501                	li	a0,0
 294:	a019                	j	29a <memcmp+0x30>
      return *p1 - *p2;
 296:	40e7853b          	subw	a0,a5,a4
}
 29a:	6422                	ld	s0,8(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret
  return 0;
 2a0:	4501                	li	a0,0
 2a2:	bfe5                	j	29a <memcmp+0x30>

00000000000002a4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a4:	1141                	addi	sp,sp,-16
 2a6:	e406                	sd	ra,8(sp)
 2a8:	e022                	sd	s0,0(sp)
 2aa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2ac:	00000097          	auipc	ra,0x0
 2b0:	f66080e7          	jalr	-154(ra) # 212 <memmove>
}
 2b4:	60a2                	ld	ra,8(sp)
 2b6:	6402                	ld	s0,0(sp)
 2b8:	0141                	addi	sp,sp,16
 2ba:	8082                	ret

00000000000002bc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2bc:	4885                	li	a7,1
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2c4:	4889                	li	a7,2
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <wait>:
.global wait
wait:
 li a7, SYS_wait
 2cc:	488d                	li	a7,3
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2d4:	4891                	li	a7,4
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <read>:
.global read
read:
 li a7, SYS_read
 2dc:	4895                	li	a7,5
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <write>:
.global write
write:
 li a7, SYS_write
 2e4:	48c1                	li	a7,16
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <close>:
.global close
close:
 li a7, SYS_close
 2ec:	48d5                	li	a7,21
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2f4:	4899                	li	a7,6
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <exec>:
.global exec
exec:
 li a7, SYS_exec
 2fc:	489d                	li	a7,7
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <open>:
.global open
open:
 li a7, SYS_open
 304:	48bd                	li	a7,15
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 30c:	48c5                	li	a7,17
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 314:	48c9                	li	a7,18
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 31c:	48a1                	li	a7,8
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <link>:
.global link
link:
 li a7, SYS_link
 324:	48cd                	li	a7,19
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 32c:	48d1                	li	a7,20
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 334:	48a5                	li	a7,9
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <dup>:
.global dup
dup:
 li a7, SYS_dup
 33c:	48a9                	li	a7,10
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 344:	48ad                	li	a7,11
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 34c:	48b1                	li	a7,12
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 354:	48b5                	li	a7,13
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 35c:	48b9                	li	a7,14
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 364:	1101                	addi	sp,sp,-32
 366:	ec06                	sd	ra,24(sp)
 368:	e822                	sd	s0,16(sp)
 36a:	1000                	addi	s0,sp,32
 36c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 370:	4605                	li	a2,1
 372:	fef40593          	addi	a1,s0,-17
 376:	00000097          	auipc	ra,0x0
 37a:	f6e080e7          	jalr	-146(ra) # 2e4 <write>
}
 37e:	60e2                	ld	ra,24(sp)
 380:	6442                	ld	s0,16(sp)
 382:	6105                	addi	sp,sp,32
 384:	8082                	ret

0000000000000386 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 386:	7139                	addi	sp,sp,-64
 388:	fc06                	sd	ra,56(sp)
 38a:	f822                	sd	s0,48(sp)
 38c:	f426                	sd	s1,40(sp)
 38e:	f04a                	sd	s2,32(sp)
 390:	ec4e                	sd	s3,24(sp)
 392:	0080                	addi	s0,sp,64
 394:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 396:	c299                	beqz	a3,39c <printint+0x16>
 398:	0805c963          	bltz	a1,42a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 39c:	2581                	sext.w	a1,a1
  neg = 0;
 39e:	4881                	li	a7,0
 3a0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3a4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3a6:	2601                	sext.w	a2,a2
 3a8:	00000517          	auipc	a0,0x0
 3ac:	4c850513          	addi	a0,a0,1224 # 870 <digits>
 3b0:	883a                	mv	a6,a4
 3b2:	2705                	addiw	a4,a4,1
 3b4:	02c5f7bb          	remuw	a5,a1,a2
 3b8:	1782                	slli	a5,a5,0x20
 3ba:	9381                	srli	a5,a5,0x20
 3bc:	97aa                	add	a5,a5,a0
 3be:	0007c783          	lbu	a5,0(a5)
 3c2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3c6:	0005879b          	sext.w	a5,a1
 3ca:	02c5d5bb          	divuw	a1,a1,a2
 3ce:	0685                	addi	a3,a3,1
 3d0:	fec7f0e3          	bgeu	a5,a2,3b0 <printint+0x2a>
  if(neg)
 3d4:	00088c63          	beqz	a7,3ec <printint+0x66>
    buf[i++] = '-';
 3d8:	fd070793          	addi	a5,a4,-48
 3dc:	00878733          	add	a4,a5,s0
 3e0:	02d00793          	li	a5,45
 3e4:	fef70823          	sb	a5,-16(a4)
 3e8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3ec:	02e05863          	blez	a4,41c <printint+0x96>
 3f0:	fc040793          	addi	a5,s0,-64
 3f4:	00e78933          	add	s2,a5,a4
 3f8:	fff78993          	addi	s3,a5,-1
 3fc:	99ba                	add	s3,s3,a4
 3fe:	377d                	addiw	a4,a4,-1
 400:	1702                	slli	a4,a4,0x20
 402:	9301                	srli	a4,a4,0x20
 404:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 408:	fff94583          	lbu	a1,-1(s2)
 40c:	8526                	mv	a0,s1
 40e:	00000097          	auipc	ra,0x0
 412:	f56080e7          	jalr	-170(ra) # 364 <putc>
  while(--i >= 0)
 416:	197d                	addi	s2,s2,-1
 418:	ff3918e3          	bne	s2,s3,408 <printint+0x82>
}
 41c:	70e2                	ld	ra,56(sp)
 41e:	7442                	ld	s0,48(sp)
 420:	74a2                	ld	s1,40(sp)
 422:	7902                	ld	s2,32(sp)
 424:	69e2                	ld	s3,24(sp)
 426:	6121                	addi	sp,sp,64
 428:	8082                	ret
    x = -xx;
 42a:	40b005bb          	negw	a1,a1
    neg = 1;
 42e:	4885                	li	a7,1
    x = -xx;
 430:	bf85                	j	3a0 <printint+0x1a>

0000000000000432 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 432:	7119                	addi	sp,sp,-128
 434:	fc86                	sd	ra,120(sp)
 436:	f8a2                	sd	s0,112(sp)
 438:	f4a6                	sd	s1,104(sp)
 43a:	f0ca                	sd	s2,96(sp)
 43c:	ecce                	sd	s3,88(sp)
 43e:	e8d2                	sd	s4,80(sp)
 440:	e4d6                	sd	s5,72(sp)
 442:	e0da                	sd	s6,64(sp)
 444:	fc5e                	sd	s7,56(sp)
 446:	f862                	sd	s8,48(sp)
 448:	f466                	sd	s9,40(sp)
 44a:	f06a                	sd	s10,32(sp)
 44c:	ec6e                	sd	s11,24(sp)
 44e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 450:	0005c903          	lbu	s2,0(a1)
 454:	18090f63          	beqz	s2,5f2 <vprintf+0x1c0>
 458:	8aaa                	mv	s5,a0
 45a:	8b32                	mv	s6,a2
 45c:	00158493          	addi	s1,a1,1
  state = 0;
 460:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 462:	02500a13          	li	s4,37
 466:	4c55                	li	s8,21
 468:	00000c97          	auipc	s9,0x0
 46c:	3b0c8c93          	addi	s9,s9,944 # 818 <malloc+0x122>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 470:	02800d93          	li	s11,40
  putc(fd, 'x');
 474:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 476:	00000b97          	auipc	s7,0x0
 47a:	3fab8b93          	addi	s7,s7,1018 # 870 <digits>
 47e:	a839                	j	49c <vprintf+0x6a>
        putc(fd, c);
 480:	85ca                	mv	a1,s2
 482:	8556                	mv	a0,s5
 484:	00000097          	auipc	ra,0x0
 488:	ee0080e7          	jalr	-288(ra) # 364 <putc>
 48c:	a019                	j	492 <vprintf+0x60>
    } else if(state == '%'){
 48e:	01498d63          	beq	s3,s4,4a8 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 492:	0485                	addi	s1,s1,1
 494:	fff4c903          	lbu	s2,-1(s1)
 498:	14090d63          	beqz	s2,5f2 <vprintf+0x1c0>
    if(state == 0){
 49c:	fe0999e3          	bnez	s3,48e <vprintf+0x5c>
      if(c == '%'){
 4a0:	ff4910e3          	bne	s2,s4,480 <vprintf+0x4e>
        state = '%';
 4a4:	89d2                	mv	s3,s4
 4a6:	b7f5                	j	492 <vprintf+0x60>
      if(c == 'd'){
 4a8:	11490c63          	beq	s2,s4,5c0 <vprintf+0x18e>
 4ac:	f9d9079b          	addiw	a5,s2,-99
 4b0:	0ff7f793          	zext.b	a5,a5
 4b4:	10fc6e63          	bltu	s8,a5,5d0 <vprintf+0x19e>
 4b8:	f9d9079b          	addiw	a5,s2,-99
 4bc:	0ff7f713          	zext.b	a4,a5
 4c0:	10ec6863          	bltu	s8,a4,5d0 <vprintf+0x19e>
 4c4:	00271793          	slli	a5,a4,0x2
 4c8:	97e6                	add	a5,a5,s9
 4ca:	439c                	lw	a5,0(a5)
 4cc:	97e6                	add	a5,a5,s9
 4ce:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4d0:	008b0913          	addi	s2,s6,8
 4d4:	4685                	li	a3,1
 4d6:	4629                	li	a2,10
 4d8:	000b2583          	lw	a1,0(s6)
 4dc:	8556                	mv	a0,s5
 4de:	00000097          	auipc	ra,0x0
 4e2:	ea8080e7          	jalr	-344(ra) # 386 <printint>
 4e6:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4e8:	4981                	li	s3,0
 4ea:	b765                	j	492 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4ec:	008b0913          	addi	s2,s6,8
 4f0:	4681                	li	a3,0
 4f2:	4629                	li	a2,10
 4f4:	000b2583          	lw	a1,0(s6)
 4f8:	8556                	mv	a0,s5
 4fa:	00000097          	auipc	ra,0x0
 4fe:	e8c080e7          	jalr	-372(ra) # 386 <printint>
 502:	8b4a                	mv	s6,s2
      state = 0;
 504:	4981                	li	s3,0
 506:	b771                	j	492 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 508:	008b0913          	addi	s2,s6,8
 50c:	4681                	li	a3,0
 50e:	866a                	mv	a2,s10
 510:	000b2583          	lw	a1,0(s6)
 514:	8556                	mv	a0,s5
 516:	00000097          	auipc	ra,0x0
 51a:	e70080e7          	jalr	-400(ra) # 386 <printint>
 51e:	8b4a                	mv	s6,s2
      state = 0;
 520:	4981                	li	s3,0
 522:	bf85                	j	492 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 524:	008b0793          	addi	a5,s6,8
 528:	f8f43423          	sd	a5,-120(s0)
 52c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 530:	03000593          	li	a1,48
 534:	8556                	mv	a0,s5
 536:	00000097          	auipc	ra,0x0
 53a:	e2e080e7          	jalr	-466(ra) # 364 <putc>
  putc(fd, 'x');
 53e:	07800593          	li	a1,120
 542:	8556                	mv	a0,s5
 544:	00000097          	auipc	ra,0x0
 548:	e20080e7          	jalr	-480(ra) # 364 <putc>
 54c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 54e:	03c9d793          	srli	a5,s3,0x3c
 552:	97de                	add	a5,a5,s7
 554:	0007c583          	lbu	a1,0(a5)
 558:	8556                	mv	a0,s5
 55a:	00000097          	auipc	ra,0x0
 55e:	e0a080e7          	jalr	-502(ra) # 364 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 562:	0992                	slli	s3,s3,0x4
 564:	397d                	addiw	s2,s2,-1
 566:	fe0914e3          	bnez	s2,54e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 56a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 56e:	4981                	li	s3,0
 570:	b70d                	j	492 <vprintf+0x60>
        s = va_arg(ap, char*);
 572:	008b0913          	addi	s2,s6,8
 576:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 57a:	02098163          	beqz	s3,59c <vprintf+0x16a>
        while(*s != 0){
 57e:	0009c583          	lbu	a1,0(s3)
 582:	c5ad                	beqz	a1,5ec <vprintf+0x1ba>
          putc(fd, *s);
 584:	8556                	mv	a0,s5
 586:	00000097          	auipc	ra,0x0
 58a:	dde080e7          	jalr	-546(ra) # 364 <putc>
          s++;
 58e:	0985                	addi	s3,s3,1
        while(*s != 0){
 590:	0009c583          	lbu	a1,0(s3)
 594:	f9e5                	bnez	a1,584 <vprintf+0x152>
        s = va_arg(ap, char*);
 596:	8b4a                	mv	s6,s2
      state = 0;
 598:	4981                	li	s3,0
 59a:	bde5                	j	492 <vprintf+0x60>
          s = "(null)";
 59c:	00000997          	auipc	s3,0x0
 5a0:	27498993          	addi	s3,s3,628 # 810 <malloc+0x11a>
        while(*s != 0){
 5a4:	85ee                	mv	a1,s11
 5a6:	bff9                	j	584 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 5a8:	008b0913          	addi	s2,s6,8
 5ac:	000b4583          	lbu	a1,0(s6)
 5b0:	8556                	mv	a0,s5
 5b2:	00000097          	auipc	ra,0x0
 5b6:	db2080e7          	jalr	-590(ra) # 364 <putc>
 5ba:	8b4a                	mv	s6,s2
      state = 0;
 5bc:	4981                	li	s3,0
 5be:	bdd1                	j	492 <vprintf+0x60>
        putc(fd, c);
 5c0:	85d2                	mv	a1,s4
 5c2:	8556                	mv	a0,s5
 5c4:	00000097          	auipc	ra,0x0
 5c8:	da0080e7          	jalr	-608(ra) # 364 <putc>
      state = 0;
 5cc:	4981                	li	s3,0
 5ce:	b5d1                	j	492 <vprintf+0x60>
        putc(fd, '%');
 5d0:	85d2                	mv	a1,s4
 5d2:	8556                	mv	a0,s5
 5d4:	00000097          	auipc	ra,0x0
 5d8:	d90080e7          	jalr	-624(ra) # 364 <putc>
        putc(fd, c);
 5dc:	85ca                	mv	a1,s2
 5de:	8556                	mv	a0,s5
 5e0:	00000097          	auipc	ra,0x0
 5e4:	d84080e7          	jalr	-636(ra) # 364 <putc>
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	b565                	j	492 <vprintf+0x60>
        s = va_arg(ap, char*);
 5ec:	8b4a                	mv	s6,s2
      state = 0;
 5ee:	4981                	li	s3,0
 5f0:	b54d                	j	492 <vprintf+0x60>
    }
  }
}
 5f2:	70e6                	ld	ra,120(sp)
 5f4:	7446                	ld	s0,112(sp)
 5f6:	74a6                	ld	s1,104(sp)
 5f8:	7906                	ld	s2,96(sp)
 5fa:	69e6                	ld	s3,88(sp)
 5fc:	6a46                	ld	s4,80(sp)
 5fe:	6aa6                	ld	s5,72(sp)
 600:	6b06                	ld	s6,64(sp)
 602:	7be2                	ld	s7,56(sp)
 604:	7c42                	ld	s8,48(sp)
 606:	7ca2                	ld	s9,40(sp)
 608:	7d02                	ld	s10,32(sp)
 60a:	6de2                	ld	s11,24(sp)
 60c:	6109                	addi	sp,sp,128
 60e:	8082                	ret

0000000000000610 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 610:	715d                	addi	sp,sp,-80
 612:	ec06                	sd	ra,24(sp)
 614:	e822                	sd	s0,16(sp)
 616:	1000                	addi	s0,sp,32
 618:	e010                	sd	a2,0(s0)
 61a:	e414                	sd	a3,8(s0)
 61c:	e818                	sd	a4,16(s0)
 61e:	ec1c                	sd	a5,24(s0)
 620:	03043023          	sd	a6,32(s0)
 624:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 628:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 62c:	8622                	mv	a2,s0
 62e:	00000097          	auipc	ra,0x0
 632:	e04080e7          	jalr	-508(ra) # 432 <vprintf>
}
 636:	60e2                	ld	ra,24(sp)
 638:	6442                	ld	s0,16(sp)
 63a:	6161                	addi	sp,sp,80
 63c:	8082                	ret

000000000000063e <printf>:

void
printf(const char *fmt, ...)
{
 63e:	711d                	addi	sp,sp,-96
 640:	ec06                	sd	ra,24(sp)
 642:	e822                	sd	s0,16(sp)
 644:	1000                	addi	s0,sp,32
 646:	e40c                	sd	a1,8(s0)
 648:	e810                	sd	a2,16(s0)
 64a:	ec14                	sd	a3,24(s0)
 64c:	f018                	sd	a4,32(s0)
 64e:	f41c                	sd	a5,40(s0)
 650:	03043823          	sd	a6,48(s0)
 654:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 658:	00840613          	addi	a2,s0,8
 65c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 660:	85aa                	mv	a1,a0
 662:	4505                	li	a0,1
 664:	00000097          	auipc	ra,0x0
 668:	dce080e7          	jalr	-562(ra) # 432 <vprintf>
}
 66c:	60e2                	ld	ra,24(sp)
 66e:	6442                	ld	s0,16(sp)
 670:	6125                	addi	sp,sp,96
 672:	8082                	ret

0000000000000674 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 674:	1141                	addi	sp,sp,-16
 676:	e422                	sd	s0,8(sp)
 678:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 67a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67e:	00000797          	auipc	a5,0x0
 682:	20a7b783          	ld	a5,522(a5) # 888 <freep>
 686:	a02d                	j	6b0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 688:	4618                	lw	a4,8(a2)
 68a:	9f2d                	addw	a4,a4,a1
 68c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 690:	6398                	ld	a4,0(a5)
 692:	6310                	ld	a2,0(a4)
 694:	a83d                	j	6d2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 696:	ff852703          	lw	a4,-8(a0)
 69a:	9f31                	addw	a4,a4,a2
 69c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 69e:	ff053683          	ld	a3,-16(a0)
 6a2:	a091                	j	6e6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a4:	6398                	ld	a4,0(a5)
 6a6:	00e7e463          	bltu	a5,a4,6ae <free+0x3a>
 6aa:	00e6ea63          	bltu	a3,a4,6be <free+0x4a>
{
 6ae:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b0:	fed7fae3          	bgeu	a5,a3,6a4 <free+0x30>
 6b4:	6398                	ld	a4,0(a5)
 6b6:	00e6e463          	bltu	a3,a4,6be <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ba:	fee7eae3          	bltu	a5,a4,6ae <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 6be:	ff852583          	lw	a1,-8(a0)
 6c2:	6390                	ld	a2,0(a5)
 6c4:	02059813          	slli	a6,a1,0x20
 6c8:	01c85713          	srli	a4,a6,0x1c
 6cc:	9736                	add	a4,a4,a3
 6ce:	fae60de3          	beq	a2,a4,688 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 6d2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6d6:	4790                	lw	a2,8(a5)
 6d8:	02061593          	slli	a1,a2,0x20
 6dc:	01c5d713          	srli	a4,a1,0x1c
 6e0:	973e                	add	a4,a4,a5
 6e2:	fae68ae3          	beq	a3,a4,696 <free+0x22>
    p->s.ptr = bp->s.ptr;
 6e6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 6e8:	00000717          	auipc	a4,0x0
 6ec:	1af73023          	sd	a5,416(a4) # 888 <freep>
}
 6f0:	6422                	ld	s0,8(sp)
 6f2:	0141                	addi	sp,sp,16
 6f4:	8082                	ret

00000000000006f6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f6:	7139                	addi	sp,sp,-64
 6f8:	fc06                	sd	ra,56(sp)
 6fa:	f822                	sd	s0,48(sp)
 6fc:	f426                	sd	s1,40(sp)
 6fe:	f04a                	sd	s2,32(sp)
 700:	ec4e                	sd	s3,24(sp)
 702:	e852                	sd	s4,16(sp)
 704:	e456                	sd	s5,8(sp)
 706:	e05a                	sd	s6,0(sp)
 708:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70a:	02051493          	slli	s1,a0,0x20
 70e:	9081                	srli	s1,s1,0x20
 710:	04bd                	addi	s1,s1,15
 712:	8091                	srli	s1,s1,0x4
 714:	0014899b          	addiw	s3,s1,1
 718:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 71a:	00000517          	auipc	a0,0x0
 71e:	16e53503          	ld	a0,366(a0) # 888 <freep>
 722:	c515                	beqz	a0,74e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 724:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 726:	4798                	lw	a4,8(a5)
 728:	02977f63          	bgeu	a4,s1,766 <malloc+0x70>
 72c:	8a4e                	mv	s4,s3
 72e:	0009871b          	sext.w	a4,s3
 732:	6685                	lui	a3,0x1
 734:	00d77363          	bgeu	a4,a3,73a <malloc+0x44>
 738:	6a05                	lui	s4,0x1
 73a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 73e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 742:	00000917          	auipc	s2,0x0
 746:	14690913          	addi	s2,s2,326 # 888 <freep>
  if(p == (char*)-1)
 74a:	5afd                	li	s5,-1
 74c:	a895                	j	7c0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 74e:	00000797          	auipc	a5,0x0
 752:	14278793          	addi	a5,a5,322 # 890 <base>
 756:	00000717          	auipc	a4,0x0
 75a:	12f73923          	sd	a5,306(a4) # 888 <freep>
 75e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 760:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 764:	b7e1                	j	72c <malloc+0x36>
      if(p->s.size == nunits)
 766:	02e48c63          	beq	s1,a4,79e <malloc+0xa8>
        p->s.size -= nunits;
 76a:	4137073b          	subw	a4,a4,s3
 76e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 770:	02071693          	slli	a3,a4,0x20
 774:	01c6d713          	srli	a4,a3,0x1c
 778:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 77a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 77e:	00000717          	auipc	a4,0x0
 782:	10a73523          	sd	a0,266(a4) # 888 <freep>
      return (void*)(p + 1);
 786:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 78a:	70e2                	ld	ra,56(sp)
 78c:	7442                	ld	s0,48(sp)
 78e:	74a2                	ld	s1,40(sp)
 790:	7902                	ld	s2,32(sp)
 792:	69e2                	ld	s3,24(sp)
 794:	6a42                	ld	s4,16(sp)
 796:	6aa2                	ld	s5,8(sp)
 798:	6b02                	ld	s6,0(sp)
 79a:	6121                	addi	sp,sp,64
 79c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 79e:	6398                	ld	a4,0(a5)
 7a0:	e118                	sd	a4,0(a0)
 7a2:	bff1                	j	77e <malloc+0x88>
  hp->s.size = nu;
 7a4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7a8:	0541                	addi	a0,a0,16
 7aa:	00000097          	auipc	ra,0x0
 7ae:	eca080e7          	jalr	-310(ra) # 674 <free>
  return freep;
 7b2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 7b6:	d971                	beqz	a0,78a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7ba:	4798                	lw	a4,8(a5)
 7bc:	fa9775e3          	bgeu	a4,s1,766 <malloc+0x70>
    if(p == freep)
 7c0:	00093703          	ld	a4,0(s2)
 7c4:	853e                	mv	a0,a5
 7c6:	fef719e3          	bne	a4,a5,7b8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 7ca:	8552                	mv	a0,s4
 7cc:	00000097          	auipc	ra,0x0
 7d0:	b80080e7          	jalr	-1152(ra) # 34c <sbrk>
  if(p == (char*)-1)
 7d4:	fd5518e3          	bne	a0,s5,7a4 <malloc+0xae>
        return 0;
 7d8:	4501                	li	a0,0
 7da:	bf45                	j	78a <malloc+0x94>
