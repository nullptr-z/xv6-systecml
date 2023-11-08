
user/_pingpong：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"

#define BUFFER_SIZE 50

int main(int argc, char *args[])
{
   0:	711d                	addi	sp,sp,-96
   2:	ec86                	sd	ra,88(sp)
   4:	e8a2                	sd	s0,80(sp)
   6:	e4a6                	sd	s1,72(sp)
   8:	1080                	addi	s0,sp,96
  char buff[BUFFER_SIZE];
  int p[2];

  if (pipe(p) < 0)
   a:	fa040513          	addi	a0,s0,-96
   e:	00000097          	auipc	ra,0x0
  12:	360080e7          	jalr	864(ra) # 36e <pipe>
  16:	06054863          	bltz	a0,86 <main+0x86>
    exit(1);

  if (fork() == 0)
  1a:	00000097          	auipc	ra,0x0
  1e:	33c080e7          	jalr	828(ra) # 356 <fork>
  22:	e53d                	bnez	a0,90 <main+0x90>
  {
    read(p[0], buff, BUFFER_SIZE);
  24:	03200613          	li	a2,50
  28:	fa840593          	addi	a1,s0,-88
  2c:	fa042503          	lw	a0,-96(s0)
  30:	00000097          	auipc	ra,0x0
  34:	346080e7          	jalr	838(ra) # 376 <read>
    // printf("<%d> child receiver: %s \n", getpid(), buff);
    printf("%d: received ping\n", getpid());
  38:	00000097          	auipc	ra,0x0
  3c:	3a6080e7          	jalr	934(ra) # 3de <getpid>
  40:	85aa                	mv	a1,a0
  42:	00001517          	auipc	a0,0x1
  46:	83650513          	addi	a0,a0,-1994 # 878 <malloc+0xe8>
  4a:	00000097          	auipc	ra,0x0
  4e:	68e080e7          	jalr	1678(ra) # 6d8 <printf>
    char *c = "I is child for you";
    write(p[1], c, strlen(c));
  52:	fa442483          	lw	s1,-92(s0)
  56:	00001517          	auipc	a0,0x1
  5a:	83a50513          	addi	a0,a0,-1990 # 890 <malloc+0x100>
  5e:	00000097          	auipc	ra,0x0
  62:	0dc080e7          	jalr	220(ra) # 13a <strlen>
  66:	0005061b          	sext.w	a2,a0
  6a:	00001597          	auipc	a1,0x1
  6e:	82658593          	addi	a1,a1,-2010 # 890 <malloc+0x100>
  72:	8526                	mv	a0,s1
  74:	00000097          	auipc	ra,0x0
  78:	30a080e7          	jalr	778(ra) # 37e <write>
    exit(1);
  7c:	4505                	li	a0,1
  7e:	00000097          	auipc	ra,0x0
  82:	2e0080e7          	jalr	736(ra) # 35e <exit>
    exit(1);
  86:	4505                	li	a0,1
  88:	00000097          	auipc	ra,0x0
  8c:	2d6080e7          	jalr	726(ra) # 35e <exit>
  }
  else
  {
    char *c = "im you father";
    write(p[1], c, strlen(c));
  90:	fa442483          	lw	s1,-92(s0)
  94:	00001517          	auipc	a0,0x1
  98:	81450513          	addi	a0,a0,-2028 # 8a8 <malloc+0x118>
  9c:	00000097          	auipc	ra,0x0
  a0:	09e080e7          	jalr	158(ra) # 13a <strlen>
  a4:	0005061b          	sext.w	a2,a0
  a8:	00001597          	auipc	a1,0x1
  ac:	80058593          	addi	a1,a1,-2048 # 8a8 <malloc+0x118>
  b0:	8526                	mv	a0,s1
  b2:	00000097          	auipc	ra,0x0
  b6:	2cc080e7          	jalr	716(ra) # 37e <write>
    read(p[0], buff, BUFFER_SIZE);
  ba:	03200613          	li	a2,50
  be:	fa840593          	addi	a1,s0,-88
  c2:	fa042503          	lw	a0,-96(s0)
  c6:	00000097          	auipc	ra,0x0
  ca:	2b0080e7          	jalr	688(ra) # 376 <read>
    // printf("<%d> parent receiver: %s \n", getpid(), buff);
    printf("%d: received pong\n", getpid());
  ce:	00000097          	auipc	ra,0x0
  d2:	310080e7          	jalr	784(ra) # 3de <getpid>
  d6:	85aa                	mv	a1,a0
  d8:	00000517          	auipc	a0,0x0
  dc:	7e050513          	addi	a0,a0,2016 # 8b8 <malloc+0x128>
  e0:	00000097          	auipc	ra,0x0
  e4:	5f8080e7          	jalr	1528(ra) # 6d8 <printf>
    exit(1);
  e8:	4505                	li	a0,1
  ea:	00000097          	auipc	ra,0x0
  ee:	274080e7          	jalr	628(ra) # 35e <exit>

00000000000000f2 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  f2:	1141                	addi	sp,sp,-16
  f4:	e422                	sd	s0,8(sp)
  f6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f8:	87aa                	mv	a5,a0
  fa:	0585                	addi	a1,a1,1
  fc:	0785                	addi	a5,a5,1
  fe:	fff5c703          	lbu	a4,-1(a1)
 102:	fee78fa3          	sb	a4,-1(a5)
 106:	fb75                	bnez	a4,fa <strcpy+0x8>
    ;
  return os;
}
 108:	6422                	ld	s0,8(sp)
 10a:	0141                	addi	sp,sp,16
 10c:	8082                	ret

000000000000010e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 10e:	1141                	addi	sp,sp,-16
 110:	e422                	sd	s0,8(sp)
 112:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 114:	00054783          	lbu	a5,0(a0)
 118:	cb91                	beqz	a5,12c <strcmp+0x1e>
 11a:	0005c703          	lbu	a4,0(a1)
 11e:	00f71763          	bne	a4,a5,12c <strcmp+0x1e>
    p++, q++;
 122:	0505                	addi	a0,a0,1
 124:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 126:	00054783          	lbu	a5,0(a0)
 12a:	fbe5                	bnez	a5,11a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 12c:	0005c503          	lbu	a0,0(a1)
}
 130:	40a7853b          	subw	a0,a5,a0
 134:	6422                	ld	s0,8(sp)
 136:	0141                	addi	sp,sp,16
 138:	8082                	ret

000000000000013a <strlen>:

uint
strlen(const char *s)
{
 13a:	1141                	addi	sp,sp,-16
 13c:	e422                	sd	s0,8(sp)
 13e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 140:	00054783          	lbu	a5,0(a0)
 144:	cf91                	beqz	a5,160 <strlen+0x26>
 146:	0505                	addi	a0,a0,1
 148:	87aa                	mv	a5,a0
 14a:	4685                	li	a3,1
 14c:	9e89                	subw	a3,a3,a0
 14e:	00f6853b          	addw	a0,a3,a5
 152:	0785                	addi	a5,a5,1
 154:	fff7c703          	lbu	a4,-1(a5)
 158:	fb7d                	bnez	a4,14e <strlen+0x14>
    ;
  return n;
}
 15a:	6422                	ld	s0,8(sp)
 15c:	0141                	addi	sp,sp,16
 15e:	8082                	ret
  for(n = 0; s[n]; n++)
 160:	4501                	li	a0,0
 162:	bfe5                	j	15a <strlen+0x20>

0000000000000164 <memset>:

void*
memset(void *dst, int c, uint n)
{
 164:	1141                	addi	sp,sp,-16
 166:	e422                	sd	s0,8(sp)
 168:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 16a:	ca19                	beqz	a2,180 <memset+0x1c>
 16c:	87aa                	mv	a5,a0
 16e:	1602                	slli	a2,a2,0x20
 170:	9201                	srli	a2,a2,0x20
 172:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 176:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 17a:	0785                	addi	a5,a5,1
 17c:	fee79de3          	bne	a5,a4,176 <memset+0x12>
  }
  return dst;
}
 180:	6422                	ld	s0,8(sp)
 182:	0141                	addi	sp,sp,16
 184:	8082                	ret

0000000000000186 <strchr>:

char*
strchr(const char *s, char c)
{
 186:	1141                	addi	sp,sp,-16
 188:	e422                	sd	s0,8(sp)
 18a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 18c:	00054783          	lbu	a5,0(a0)
 190:	cb99                	beqz	a5,1a6 <strchr+0x20>
    if(*s == c)
 192:	00f58763          	beq	a1,a5,1a0 <strchr+0x1a>
  for(; *s; s++)
 196:	0505                	addi	a0,a0,1
 198:	00054783          	lbu	a5,0(a0)
 19c:	fbfd                	bnez	a5,192 <strchr+0xc>
      return (char*)s;
  return 0;
 19e:	4501                	li	a0,0
}
 1a0:	6422                	ld	s0,8(sp)
 1a2:	0141                	addi	sp,sp,16
 1a4:	8082                	ret
  return 0;
 1a6:	4501                	li	a0,0
 1a8:	bfe5                	j	1a0 <strchr+0x1a>

00000000000001aa <gets>:

char*
gets(char *buf, int max)
{
 1aa:	711d                	addi	sp,sp,-96
 1ac:	ec86                	sd	ra,88(sp)
 1ae:	e8a2                	sd	s0,80(sp)
 1b0:	e4a6                	sd	s1,72(sp)
 1b2:	e0ca                	sd	s2,64(sp)
 1b4:	fc4e                	sd	s3,56(sp)
 1b6:	f852                	sd	s4,48(sp)
 1b8:	f456                	sd	s5,40(sp)
 1ba:	f05a                	sd	s6,32(sp)
 1bc:	ec5e                	sd	s7,24(sp)
 1be:	1080                	addi	s0,sp,96
 1c0:	8baa                	mv	s7,a0
 1c2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c4:	892a                	mv	s2,a0
 1c6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1c8:	4aa9                	li	s5,10
 1ca:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1cc:	89a6                	mv	s3,s1
 1ce:	2485                	addiw	s1,s1,1
 1d0:	0344d863          	bge	s1,s4,200 <gets+0x56>
    cc = read(0, &c, 1);
 1d4:	4605                	li	a2,1
 1d6:	faf40593          	addi	a1,s0,-81
 1da:	4501                	li	a0,0
 1dc:	00000097          	auipc	ra,0x0
 1e0:	19a080e7          	jalr	410(ra) # 376 <read>
    if(cc < 1)
 1e4:	00a05e63          	blez	a0,200 <gets+0x56>
    buf[i++] = c;
 1e8:	faf44783          	lbu	a5,-81(s0)
 1ec:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1f0:	01578763          	beq	a5,s5,1fe <gets+0x54>
 1f4:	0905                	addi	s2,s2,1
 1f6:	fd679be3          	bne	a5,s6,1cc <gets+0x22>
  for(i=0; i+1 < max; ){
 1fa:	89a6                	mv	s3,s1
 1fc:	a011                	j	200 <gets+0x56>
 1fe:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 200:	99de                	add	s3,s3,s7
 202:	00098023          	sb	zero,0(s3)
  return buf;
}
 206:	855e                	mv	a0,s7
 208:	60e6                	ld	ra,88(sp)
 20a:	6446                	ld	s0,80(sp)
 20c:	64a6                	ld	s1,72(sp)
 20e:	6906                	ld	s2,64(sp)
 210:	79e2                	ld	s3,56(sp)
 212:	7a42                	ld	s4,48(sp)
 214:	7aa2                	ld	s5,40(sp)
 216:	7b02                	ld	s6,32(sp)
 218:	6be2                	ld	s7,24(sp)
 21a:	6125                	addi	sp,sp,96
 21c:	8082                	ret

000000000000021e <stat>:

int
stat(const char *n, struct stat *st)
{
 21e:	1101                	addi	sp,sp,-32
 220:	ec06                	sd	ra,24(sp)
 222:	e822                	sd	s0,16(sp)
 224:	e426                	sd	s1,8(sp)
 226:	e04a                	sd	s2,0(sp)
 228:	1000                	addi	s0,sp,32
 22a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22c:	4581                	li	a1,0
 22e:	00000097          	auipc	ra,0x0
 232:	170080e7          	jalr	368(ra) # 39e <open>
  if(fd < 0)
 236:	02054563          	bltz	a0,260 <stat+0x42>
 23a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 23c:	85ca                	mv	a1,s2
 23e:	00000097          	auipc	ra,0x0
 242:	178080e7          	jalr	376(ra) # 3b6 <fstat>
 246:	892a                	mv	s2,a0
  close(fd);
 248:	8526                	mv	a0,s1
 24a:	00000097          	auipc	ra,0x0
 24e:	13c080e7          	jalr	316(ra) # 386 <close>
  return r;
}
 252:	854a                	mv	a0,s2
 254:	60e2                	ld	ra,24(sp)
 256:	6442                	ld	s0,16(sp)
 258:	64a2                	ld	s1,8(sp)
 25a:	6902                	ld	s2,0(sp)
 25c:	6105                	addi	sp,sp,32
 25e:	8082                	ret
    return -1;
 260:	597d                	li	s2,-1
 262:	bfc5                	j	252 <stat+0x34>

0000000000000264 <atoi>:

int
atoi(const char *s)
{
 264:	1141                	addi	sp,sp,-16
 266:	e422                	sd	s0,8(sp)
 268:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26a:	00054683          	lbu	a3,0(a0)
 26e:	fd06879b          	addiw	a5,a3,-48
 272:	0ff7f793          	zext.b	a5,a5
 276:	4625                	li	a2,9
 278:	02f66863          	bltu	a2,a5,2a8 <atoi+0x44>
 27c:	872a                	mv	a4,a0
  n = 0;
 27e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 280:	0705                	addi	a4,a4,1
 282:	0025179b          	slliw	a5,a0,0x2
 286:	9fa9                	addw	a5,a5,a0
 288:	0017979b          	slliw	a5,a5,0x1
 28c:	9fb5                	addw	a5,a5,a3
 28e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 292:	00074683          	lbu	a3,0(a4)
 296:	fd06879b          	addiw	a5,a3,-48
 29a:	0ff7f793          	zext.b	a5,a5
 29e:	fef671e3          	bgeu	a2,a5,280 <atoi+0x1c>
  return n;
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret
  n = 0;
 2a8:	4501                	li	a0,0
 2aa:	bfe5                	j	2a2 <atoi+0x3e>

00000000000002ac <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e422                	sd	s0,8(sp)
 2b0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2b2:	02b57463          	bgeu	a0,a1,2da <memmove+0x2e>
    while(n-- > 0)
 2b6:	00c05f63          	blez	a2,2d4 <memmove+0x28>
 2ba:	1602                	slli	a2,a2,0x20
 2bc:	9201                	srli	a2,a2,0x20
 2be:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2c2:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c4:	0585                	addi	a1,a1,1
 2c6:	0705                	addi	a4,a4,1
 2c8:	fff5c683          	lbu	a3,-1(a1)
 2cc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2d0:	fee79ae3          	bne	a5,a4,2c4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
    dst += n;
 2da:	00c50733          	add	a4,a0,a2
    src += n;
 2de:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2e0:	fec05ae3          	blez	a2,2d4 <memmove+0x28>
 2e4:	fff6079b          	addiw	a5,a2,-1
 2e8:	1782                	slli	a5,a5,0x20
 2ea:	9381                	srli	a5,a5,0x20
 2ec:	fff7c793          	not	a5,a5
 2f0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f2:	15fd                	addi	a1,a1,-1
 2f4:	177d                	addi	a4,a4,-1
 2f6:	0005c683          	lbu	a3,0(a1)
 2fa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2fe:	fee79ae3          	bne	a5,a4,2f2 <memmove+0x46>
 302:	bfc9                	j	2d4 <memmove+0x28>

0000000000000304 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 304:	1141                	addi	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 30a:	ca05                	beqz	a2,33a <memcmp+0x36>
 30c:	fff6069b          	addiw	a3,a2,-1
 310:	1682                	slli	a3,a3,0x20
 312:	9281                	srli	a3,a3,0x20
 314:	0685                	addi	a3,a3,1
 316:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 318:	00054783          	lbu	a5,0(a0)
 31c:	0005c703          	lbu	a4,0(a1)
 320:	00e79863          	bne	a5,a4,330 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 324:	0505                	addi	a0,a0,1
    p2++;
 326:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 328:	fed518e3          	bne	a0,a3,318 <memcmp+0x14>
  }
  return 0;
 32c:	4501                	li	a0,0
 32e:	a019                	j	334 <memcmp+0x30>
      return *p1 - *p2;
 330:	40e7853b          	subw	a0,a5,a4
}
 334:	6422                	ld	s0,8(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret
  return 0;
 33a:	4501                	li	a0,0
 33c:	bfe5                	j	334 <memcmp+0x30>

000000000000033e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e406                	sd	ra,8(sp)
 342:	e022                	sd	s0,0(sp)
 344:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 346:	00000097          	auipc	ra,0x0
 34a:	f66080e7          	jalr	-154(ra) # 2ac <memmove>
}
 34e:	60a2                	ld	ra,8(sp)
 350:	6402                	ld	s0,0(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret

0000000000000356 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 356:	4885                	li	a7,1
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <exit>:
.global exit
exit:
 li a7, SYS_exit
 35e:	4889                	li	a7,2
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <wait>:
.global wait
wait:
 li a7, SYS_wait
 366:	488d                	li	a7,3
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 36e:	4891                	li	a7,4
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <read>:
.global read
read:
 li a7, SYS_read
 376:	4895                	li	a7,5
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <write>:
.global write
write:
 li a7, SYS_write
 37e:	48c1                	li	a7,16
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <close>:
.global close
close:
 li a7, SYS_close
 386:	48d5                	li	a7,21
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <kill>:
.global kill
kill:
 li a7, SYS_kill
 38e:	4899                	li	a7,6
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <exec>:
.global exec
exec:
 li a7, SYS_exec
 396:	489d                	li	a7,7
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <open>:
.global open
open:
 li a7, SYS_open
 39e:	48bd                	li	a7,15
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a6:	48c5                	li	a7,17
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3ae:	48c9                	li	a7,18
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b6:	48a1                	li	a7,8
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <link>:
.global link
link:
 li a7, SYS_link
 3be:	48cd                	li	a7,19
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c6:	48d1                	li	a7,20
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ce:	48a5                	li	a7,9
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d6:	48a9                	li	a7,10
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3de:	48ad                	li	a7,11
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e6:	48b1                	li	a7,12
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ee:	48b5                	li	a7,13
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f6:	48b9                	li	a7,14
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3fe:	1101                	addi	sp,sp,-32
 400:	ec06                	sd	ra,24(sp)
 402:	e822                	sd	s0,16(sp)
 404:	1000                	addi	s0,sp,32
 406:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 40a:	4605                	li	a2,1
 40c:	fef40593          	addi	a1,s0,-17
 410:	00000097          	auipc	ra,0x0
 414:	f6e080e7          	jalr	-146(ra) # 37e <write>
}
 418:	60e2                	ld	ra,24(sp)
 41a:	6442                	ld	s0,16(sp)
 41c:	6105                	addi	sp,sp,32
 41e:	8082                	ret

0000000000000420 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	7139                	addi	sp,sp,-64
 422:	fc06                	sd	ra,56(sp)
 424:	f822                	sd	s0,48(sp)
 426:	f426                	sd	s1,40(sp)
 428:	f04a                	sd	s2,32(sp)
 42a:	ec4e                	sd	s3,24(sp)
 42c:	0080                	addi	s0,sp,64
 42e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 430:	c299                	beqz	a3,436 <printint+0x16>
 432:	0805c963          	bltz	a1,4c4 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 436:	2581                	sext.w	a1,a1
  neg = 0;
 438:	4881                	li	a7,0
 43a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 43e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 440:	2601                	sext.w	a2,a2
 442:	00000517          	auipc	a0,0x0
 446:	4ee50513          	addi	a0,a0,1262 # 930 <digits>
 44a:	883a                	mv	a6,a4
 44c:	2705                	addiw	a4,a4,1
 44e:	02c5f7bb          	remuw	a5,a1,a2
 452:	1782                	slli	a5,a5,0x20
 454:	9381                	srli	a5,a5,0x20
 456:	97aa                	add	a5,a5,a0
 458:	0007c783          	lbu	a5,0(a5)
 45c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 460:	0005879b          	sext.w	a5,a1
 464:	02c5d5bb          	divuw	a1,a1,a2
 468:	0685                	addi	a3,a3,1
 46a:	fec7f0e3          	bgeu	a5,a2,44a <printint+0x2a>
  if(neg)
 46e:	00088c63          	beqz	a7,486 <printint+0x66>
    buf[i++] = '-';
 472:	fd070793          	addi	a5,a4,-48
 476:	00878733          	add	a4,a5,s0
 47a:	02d00793          	li	a5,45
 47e:	fef70823          	sb	a5,-16(a4)
 482:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 486:	02e05863          	blez	a4,4b6 <printint+0x96>
 48a:	fc040793          	addi	a5,s0,-64
 48e:	00e78933          	add	s2,a5,a4
 492:	fff78993          	addi	s3,a5,-1
 496:	99ba                	add	s3,s3,a4
 498:	377d                	addiw	a4,a4,-1
 49a:	1702                	slli	a4,a4,0x20
 49c:	9301                	srli	a4,a4,0x20
 49e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4a2:	fff94583          	lbu	a1,-1(s2)
 4a6:	8526                	mv	a0,s1
 4a8:	00000097          	auipc	ra,0x0
 4ac:	f56080e7          	jalr	-170(ra) # 3fe <putc>
  while(--i >= 0)
 4b0:	197d                	addi	s2,s2,-1
 4b2:	ff3918e3          	bne	s2,s3,4a2 <printint+0x82>
}
 4b6:	70e2                	ld	ra,56(sp)
 4b8:	7442                	ld	s0,48(sp)
 4ba:	74a2                	ld	s1,40(sp)
 4bc:	7902                	ld	s2,32(sp)
 4be:	69e2                	ld	s3,24(sp)
 4c0:	6121                	addi	sp,sp,64
 4c2:	8082                	ret
    x = -xx;
 4c4:	40b005bb          	negw	a1,a1
    neg = 1;
 4c8:	4885                	li	a7,1
    x = -xx;
 4ca:	bf85                	j	43a <printint+0x1a>

00000000000004cc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4cc:	7119                	addi	sp,sp,-128
 4ce:	fc86                	sd	ra,120(sp)
 4d0:	f8a2                	sd	s0,112(sp)
 4d2:	f4a6                	sd	s1,104(sp)
 4d4:	f0ca                	sd	s2,96(sp)
 4d6:	ecce                	sd	s3,88(sp)
 4d8:	e8d2                	sd	s4,80(sp)
 4da:	e4d6                	sd	s5,72(sp)
 4dc:	e0da                	sd	s6,64(sp)
 4de:	fc5e                	sd	s7,56(sp)
 4e0:	f862                	sd	s8,48(sp)
 4e2:	f466                	sd	s9,40(sp)
 4e4:	f06a                	sd	s10,32(sp)
 4e6:	ec6e                	sd	s11,24(sp)
 4e8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4ea:	0005c903          	lbu	s2,0(a1)
 4ee:	18090f63          	beqz	s2,68c <vprintf+0x1c0>
 4f2:	8aaa                	mv	s5,a0
 4f4:	8b32                	mv	s6,a2
 4f6:	00158493          	addi	s1,a1,1
  state = 0;
 4fa:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4fc:	02500a13          	li	s4,37
 500:	4c55                	li	s8,21
 502:	00000c97          	auipc	s9,0x0
 506:	3d6c8c93          	addi	s9,s9,982 # 8d8 <malloc+0x148>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 50a:	02800d93          	li	s11,40
  putc(fd, 'x');
 50e:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 510:	00000b97          	auipc	s7,0x0
 514:	420b8b93          	addi	s7,s7,1056 # 930 <digits>
 518:	a839                	j	536 <vprintf+0x6a>
        putc(fd, c);
 51a:	85ca                	mv	a1,s2
 51c:	8556                	mv	a0,s5
 51e:	00000097          	auipc	ra,0x0
 522:	ee0080e7          	jalr	-288(ra) # 3fe <putc>
 526:	a019                	j	52c <vprintf+0x60>
    } else if(state == '%'){
 528:	01498d63          	beq	s3,s4,542 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 52c:	0485                	addi	s1,s1,1
 52e:	fff4c903          	lbu	s2,-1(s1)
 532:	14090d63          	beqz	s2,68c <vprintf+0x1c0>
    if(state == 0){
 536:	fe0999e3          	bnez	s3,528 <vprintf+0x5c>
      if(c == '%'){
 53a:	ff4910e3          	bne	s2,s4,51a <vprintf+0x4e>
        state = '%';
 53e:	89d2                	mv	s3,s4
 540:	b7f5                	j	52c <vprintf+0x60>
      if(c == 'd'){
 542:	11490c63          	beq	s2,s4,65a <vprintf+0x18e>
 546:	f9d9079b          	addiw	a5,s2,-99
 54a:	0ff7f793          	zext.b	a5,a5
 54e:	10fc6e63          	bltu	s8,a5,66a <vprintf+0x19e>
 552:	f9d9079b          	addiw	a5,s2,-99
 556:	0ff7f713          	zext.b	a4,a5
 55a:	10ec6863          	bltu	s8,a4,66a <vprintf+0x19e>
 55e:	00271793          	slli	a5,a4,0x2
 562:	97e6                	add	a5,a5,s9
 564:	439c                	lw	a5,0(a5)
 566:	97e6                	add	a5,a5,s9
 568:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 56a:	008b0913          	addi	s2,s6,8
 56e:	4685                	li	a3,1
 570:	4629                	li	a2,10
 572:	000b2583          	lw	a1,0(s6)
 576:	8556                	mv	a0,s5
 578:	00000097          	auipc	ra,0x0
 57c:	ea8080e7          	jalr	-344(ra) # 420 <printint>
 580:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 582:	4981                	li	s3,0
 584:	b765                	j	52c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 586:	008b0913          	addi	s2,s6,8
 58a:	4681                	li	a3,0
 58c:	4629                	li	a2,10
 58e:	000b2583          	lw	a1,0(s6)
 592:	8556                	mv	a0,s5
 594:	00000097          	auipc	ra,0x0
 598:	e8c080e7          	jalr	-372(ra) # 420 <printint>
 59c:	8b4a                	mv	s6,s2
      state = 0;
 59e:	4981                	li	s3,0
 5a0:	b771                	j	52c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5a2:	008b0913          	addi	s2,s6,8
 5a6:	4681                	li	a3,0
 5a8:	866a                	mv	a2,s10
 5aa:	000b2583          	lw	a1,0(s6)
 5ae:	8556                	mv	a0,s5
 5b0:	00000097          	auipc	ra,0x0
 5b4:	e70080e7          	jalr	-400(ra) # 420 <printint>
 5b8:	8b4a                	mv	s6,s2
      state = 0;
 5ba:	4981                	li	s3,0
 5bc:	bf85                	j	52c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5be:	008b0793          	addi	a5,s6,8
 5c2:	f8f43423          	sd	a5,-120(s0)
 5c6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5ca:	03000593          	li	a1,48
 5ce:	8556                	mv	a0,s5
 5d0:	00000097          	auipc	ra,0x0
 5d4:	e2e080e7          	jalr	-466(ra) # 3fe <putc>
  putc(fd, 'x');
 5d8:	07800593          	li	a1,120
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	e20080e7          	jalr	-480(ra) # 3fe <putc>
 5e6:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5e8:	03c9d793          	srli	a5,s3,0x3c
 5ec:	97de                	add	a5,a5,s7
 5ee:	0007c583          	lbu	a1,0(a5)
 5f2:	8556                	mv	a0,s5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	e0a080e7          	jalr	-502(ra) # 3fe <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5fc:	0992                	slli	s3,s3,0x4
 5fe:	397d                	addiw	s2,s2,-1
 600:	fe0914e3          	bnez	s2,5e8 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 604:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 608:	4981                	li	s3,0
 60a:	b70d                	j	52c <vprintf+0x60>
        s = va_arg(ap, char*);
 60c:	008b0913          	addi	s2,s6,8
 610:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 614:	02098163          	beqz	s3,636 <vprintf+0x16a>
        while(*s != 0){
 618:	0009c583          	lbu	a1,0(s3)
 61c:	c5ad                	beqz	a1,686 <vprintf+0x1ba>
          putc(fd, *s);
 61e:	8556                	mv	a0,s5
 620:	00000097          	auipc	ra,0x0
 624:	dde080e7          	jalr	-546(ra) # 3fe <putc>
          s++;
 628:	0985                	addi	s3,s3,1
        while(*s != 0){
 62a:	0009c583          	lbu	a1,0(s3)
 62e:	f9e5                	bnez	a1,61e <vprintf+0x152>
        s = va_arg(ap, char*);
 630:	8b4a                	mv	s6,s2
      state = 0;
 632:	4981                	li	s3,0
 634:	bde5                	j	52c <vprintf+0x60>
          s = "(null)";
 636:	00000997          	auipc	s3,0x0
 63a:	29a98993          	addi	s3,s3,666 # 8d0 <malloc+0x140>
        while(*s != 0){
 63e:	85ee                	mv	a1,s11
 640:	bff9                	j	61e <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 642:	008b0913          	addi	s2,s6,8
 646:	000b4583          	lbu	a1,0(s6)
 64a:	8556                	mv	a0,s5
 64c:	00000097          	auipc	ra,0x0
 650:	db2080e7          	jalr	-590(ra) # 3fe <putc>
 654:	8b4a                	mv	s6,s2
      state = 0;
 656:	4981                	li	s3,0
 658:	bdd1                	j	52c <vprintf+0x60>
        putc(fd, c);
 65a:	85d2                	mv	a1,s4
 65c:	8556                	mv	a0,s5
 65e:	00000097          	auipc	ra,0x0
 662:	da0080e7          	jalr	-608(ra) # 3fe <putc>
      state = 0;
 666:	4981                	li	s3,0
 668:	b5d1                	j	52c <vprintf+0x60>
        putc(fd, '%');
 66a:	85d2                	mv	a1,s4
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	d90080e7          	jalr	-624(ra) # 3fe <putc>
        putc(fd, c);
 676:	85ca                	mv	a1,s2
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	d84080e7          	jalr	-636(ra) # 3fe <putc>
      state = 0;
 682:	4981                	li	s3,0
 684:	b565                	j	52c <vprintf+0x60>
        s = va_arg(ap, char*);
 686:	8b4a                	mv	s6,s2
      state = 0;
 688:	4981                	li	s3,0
 68a:	b54d                	j	52c <vprintf+0x60>
    }
  }
}
 68c:	70e6                	ld	ra,120(sp)
 68e:	7446                	ld	s0,112(sp)
 690:	74a6                	ld	s1,104(sp)
 692:	7906                	ld	s2,96(sp)
 694:	69e6                	ld	s3,88(sp)
 696:	6a46                	ld	s4,80(sp)
 698:	6aa6                	ld	s5,72(sp)
 69a:	6b06                	ld	s6,64(sp)
 69c:	7be2                	ld	s7,56(sp)
 69e:	7c42                	ld	s8,48(sp)
 6a0:	7ca2                	ld	s9,40(sp)
 6a2:	7d02                	ld	s10,32(sp)
 6a4:	6de2                	ld	s11,24(sp)
 6a6:	6109                	addi	sp,sp,128
 6a8:	8082                	ret

00000000000006aa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6aa:	715d                	addi	sp,sp,-80
 6ac:	ec06                	sd	ra,24(sp)
 6ae:	e822                	sd	s0,16(sp)
 6b0:	1000                	addi	s0,sp,32
 6b2:	e010                	sd	a2,0(s0)
 6b4:	e414                	sd	a3,8(s0)
 6b6:	e818                	sd	a4,16(s0)
 6b8:	ec1c                	sd	a5,24(s0)
 6ba:	03043023          	sd	a6,32(s0)
 6be:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6c2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6c6:	8622                	mv	a2,s0
 6c8:	00000097          	auipc	ra,0x0
 6cc:	e04080e7          	jalr	-508(ra) # 4cc <vprintf>
}
 6d0:	60e2                	ld	ra,24(sp)
 6d2:	6442                	ld	s0,16(sp)
 6d4:	6161                	addi	sp,sp,80
 6d6:	8082                	ret

00000000000006d8 <printf>:

void
printf(const char *fmt, ...)
{
 6d8:	711d                	addi	sp,sp,-96
 6da:	ec06                	sd	ra,24(sp)
 6dc:	e822                	sd	s0,16(sp)
 6de:	1000                	addi	s0,sp,32
 6e0:	e40c                	sd	a1,8(s0)
 6e2:	e810                	sd	a2,16(s0)
 6e4:	ec14                	sd	a3,24(s0)
 6e6:	f018                	sd	a4,32(s0)
 6e8:	f41c                	sd	a5,40(s0)
 6ea:	03043823          	sd	a6,48(s0)
 6ee:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6f2:	00840613          	addi	a2,s0,8
 6f6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6fa:	85aa                	mv	a1,a0
 6fc:	4505                	li	a0,1
 6fe:	00000097          	auipc	ra,0x0
 702:	dce080e7          	jalr	-562(ra) # 4cc <vprintf>
}
 706:	60e2                	ld	ra,24(sp)
 708:	6442                	ld	s0,16(sp)
 70a:	6125                	addi	sp,sp,96
 70c:	8082                	ret

000000000000070e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 70e:	1141                	addi	sp,sp,-16
 710:	e422                	sd	s0,8(sp)
 712:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 714:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 718:	00000797          	auipc	a5,0x0
 71c:	2307b783          	ld	a5,560(a5) # 948 <freep>
 720:	a02d                	j	74a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 722:	4618                	lw	a4,8(a2)
 724:	9f2d                	addw	a4,a4,a1
 726:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 72a:	6398                	ld	a4,0(a5)
 72c:	6310                	ld	a2,0(a4)
 72e:	a83d                	j	76c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 730:	ff852703          	lw	a4,-8(a0)
 734:	9f31                	addw	a4,a4,a2
 736:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 738:	ff053683          	ld	a3,-16(a0)
 73c:	a091                	j	780 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73e:	6398                	ld	a4,0(a5)
 740:	00e7e463          	bltu	a5,a4,748 <free+0x3a>
 744:	00e6ea63          	bltu	a3,a4,758 <free+0x4a>
{
 748:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74a:	fed7fae3          	bgeu	a5,a3,73e <free+0x30>
 74e:	6398                	ld	a4,0(a5)
 750:	00e6e463          	bltu	a3,a4,758 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	fee7eae3          	bltu	a5,a4,748 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 758:	ff852583          	lw	a1,-8(a0)
 75c:	6390                	ld	a2,0(a5)
 75e:	02059813          	slli	a6,a1,0x20
 762:	01c85713          	srli	a4,a6,0x1c
 766:	9736                	add	a4,a4,a3
 768:	fae60de3          	beq	a2,a4,722 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 76c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 770:	4790                	lw	a2,8(a5)
 772:	02061593          	slli	a1,a2,0x20
 776:	01c5d713          	srli	a4,a1,0x1c
 77a:	973e                	add	a4,a4,a5
 77c:	fae68ae3          	beq	a3,a4,730 <free+0x22>
    p->s.ptr = bp->s.ptr;
 780:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 782:	00000717          	auipc	a4,0x0
 786:	1cf73323          	sd	a5,454(a4) # 948 <freep>
}
 78a:	6422                	ld	s0,8(sp)
 78c:	0141                	addi	sp,sp,16
 78e:	8082                	ret

0000000000000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	7139                	addi	sp,sp,-64
 792:	fc06                	sd	ra,56(sp)
 794:	f822                	sd	s0,48(sp)
 796:	f426                	sd	s1,40(sp)
 798:	f04a                	sd	s2,32(sp)
 79a:	ec4e                	sd	s3,24(sp)
 79c:	e852                	sd	s4,16(sp)
 79e:	e456                	sd	s5,8(sp)
 7a0:	e05a                	sd	s6,0(sp)
 7a2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a4:	02051493          	slli	s1,a0,0x20
 7a8:	9081                	srli	s1,s1,0x20
 7aa:	04bd                	addi	s1,s1,15
 7ac:	8091                	srli	s1,s1,0x4
 7ae:	0014899b          	addiw	s3,s1,1
 7b2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7b4:	00000517          	auipc	a0,0x0
 7b8:	19453503          	ld	a0,404(a0) # 948 <freep>
 7bc:	c515                	beqz	a0,7e8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7be:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c0:	4798                	lw	a4,8(a5)
 7c2:	02977f63          	bgeu	a4,s1,800 <malloc+0x70>
 7c6:	8a4e                	mv	s4,s3
 7c8:	0009871b          	sext.w	a4,s3
 7cc:	6685                	lui	a3,0x1
 7ce:	00d77363          	bgeu	a4,a3,7d4 <malloc+0x44>
 7d2:	6a05                	lui	s4,0x1
 7d4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7d8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7dc:	00000917          	auipc	s2,0x0
 7e0:	16c90913          	addi	s2,s2,364 # 948 <freep>
  if(p == (char*)-1)
 7e4:	5afd                	li	s5,-1
 7e6:	a895                	j	85a <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 7e8:	00000797          	auipc	a5,0x0
 7ec:	16878793          	addi	a5,a5,360 # 950 <base>
 7f0:	00000717          	auipc	a4,0x0
 7f4:	14f73c23          	sd	a5,344(a4) # 948 <freep>
 7f8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7fa:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7fe:	b7e1                	j	7c6 <malloc+0x36>
      if(p->s.size == nunits)
 800:	02e48c63          	beq	s1,a4,838 <malloc+0xa8>
        p->s.size -= nunits;
 804:	4137073b          	subw	a4,a4,s3
 808:	c798                	sw	a4,8(a5)
        p += p->s.size;
 80a:	02071693          	slli	a3,a4,0x20
 80e:	01c6d713          	srli	a4,a3,0x1c
 812:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 814:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 818:	00000717          	auipc	a4,0x0
 81c:	12a73823          	sd	a0,304(a4) # 948 <freep>
      return (void*)(p + 1);
 820:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 824:	70e2                	ld	ra,56(sp)
 826:	7442                	ld	s0,48(sp)
 828:	74a2                	ld	s1,40(sp)
 82a:	7902                	ld	s2,32(sp)
 82c:	69e2                	ld	s3,24(sp)
 82e:	6a42                	ld	s4,16(sp)
 830:	6aa2                	ld	s5,8(sp)
 832:	6b02                	ld	s6,0(sp)
 834:	6121                	addi	sp,sp,64
 836:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 838:	6398                	ld	a4,0(a5)
 83a:	e118                	sd	a4,0(a0)
 83c:	bff1                	j	818 <malloc+0x88>
  hp->s.size = nu;
 83e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 842:	0541                	addi	a0,a0,16
 844:	00000097          	auipc	ra,0x0
 848:	eca080e7          	jalr	-310(ra) # 70e <free>
  return freep;
 84c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 850:	d971                	beqz	a0,824 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 852:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 854:	4798                	lw	a4,8(a5)
 856:	fa9775e3          	bgeu	a4,s1,800 <malloc+0x70>
    if(p == freep)
 85a:	00093703          	ld	a4,0(s2)
 85e:	853e                	mv	a0,a5
 860:	fef719e3          	bne	a4,a5,852 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 864:	8552                	mv	a0,s4
 866:	00000097          	auipc	ra,0x0
 86a:	b80080e7          	jalr	-1152(ra) # 3e6 <sbrk>
  if(p == (char*)-1)
 86e:	fd5518e3          	bne	a0,s5,83e <malloc+0xae>
        return 0;
 872:	4501                	li	a0,0
 874:	bf45                	j	824 <malloc+0x94>
