
test.hex:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
   0:	00002117          	auipc	sp,0x2
   4:	ffc10113          	addi	sp,sp,-4 # 1ffc <stack>
   8:	30c0006f          	j	314 <main>
   c:	ff5ff06f          	j	0 <_start>

00000010 <integer_to_bcd>:
  10:	fd010113          	addi	sp,sp,-48
  14:	02112623          	sw	ra,44(sp)
  18:	02812423          	sw	s0,40(sp)
  1c:	03010413          	addi	s0,sp,48
  20:	fca42e23          	sw	a0,-36(s0)
  24:	fe042623          	sw	zero,-20(s0)
  28:	fe042423          	sw	zero,-24(s0)
  2c:	0580006f          	j	84 <integer_to_bcd+0x74>
  30:	fdc42783          	lw	a5,-36(s0)
  34:	00a00593          	li	a1,10
  38:	00078513          	mv	a0,a5
  3c:	450000ef          	jal	ra,48c <__umodsi3>
  40:	00050793          	mv	a5,a0
  44:	00078713          	mv	a4,a5
  48:	fe842783          	lw	a5,-24(s0)
  4c:	00279793          	slli	a5,a5,0x2
  50:	00f717b3          	sll	a5,a4,a5
  54:	fec42703          	lw	a4,-20(s0)
  58:	00f767b3          	or	a5,a4,a5
  5c:	fef42623          	sw	a5,-20(s0)
  60:	fdc42783          	lw	a5,-36(s0)
  64:	00a00593          	li	a1,10
  68:	00078513          	mv	a0,a5
  6c:	3d8000ef          	jal	ra,444 <__udivsi3>
  70:	00050793          	mv	a5,a0
  74:	fcf42e23          	sw	a5,-36(s0)
  78:	fe842783          	lw	a5,-24(s0)
  7c:	00178793          	addi	a5,a5,1
  80:	fef42423          	sw	a5,-24(s0)
  84:	fdc42783          	lw	a5,-36(s0)
  88:	fa0794e3          	bnez	a5,30 <integer_to_bcd+0x20>
  8c:	fec42783          	lw	a5,-20(s0)
  90:	00078513          	mv	a0,a5
  94:	02c12083          	lw	ra,44(sp)
  98:	02812403          	lw	s0,40(sp)
  9c:	03010113          	addi	sp,sp,48
  a0:	00008067          	ret

000000a4 <tx_write>:
  a4:	fe010113          	addi	sp,sp,-32
  a8:	00812e23          	sw	s0,28(sp)
  ac:	02010413          	addi	s0,sp,32
  b0:	fea42623          	sw	a0,-20(s0)
  b4:	00000013          	nop
  b8:	000087b7          	lui	a5,0x8
  bc:	06878793          	addi	a5,a5,104 # 8068 <stack+0x606c>
  c0:	0007a783          	lw	a5,0(a5)
  c4:	0017f793          	andi	a5,a5,1
  c8:	fe0798e3          	bnez	a5,b8 <tx_write+0x14>
  cc:	000087b7          	lui	a5,0x8
  d0:	06078793          	addi	a5,a5,96 # 8060 <stack+0x6064>
  d4:	fec42703          	lw	a4,-20(s0)
  d8:	00e7a023          	sw	a4,0(a5)
  dc:	00000013          	nop
  e0:	01c12403          	lw	s0,28(sp)
  e4:	02010113          	addi	sp,sp,32
  e8:	00008067          	ret

000000ec <send_string>:
  ec:	fe010113          	addi	sp,sp,-32
  f0:	00112e23          	sw	ra,28(sp)
  f4:	00812c23          	sw	s0,24(sp)
  f8:	02010413          	addi	s0,sp,32
  fc:	fea42623          	sw	a0,-20(s0)
 100:	01c0006f          	j	11c <send_string+0x30>
 104:	fec42783          	lw	a5,-20(s0)
 108:	00178713          	addi	a4,a5,1
 10c:	fee42623          	sw	a4,-20(s0)
 110:	0007c783          	lbu	a5,0(a5)
 114:	00078513          	mv	a0,a5
 118:	f8dff0ef          	jal	ra,a4 <tx_write>
 11c:	fec42783          	lw	a5,-20(s0)
 120:	0007c783          	lbu	a5,0(a5)
 124:	fe0790e3          	bnez	a5,104 <send_string+0x18>
 128:	00000013          	nop
 12c:	01c12083          	lw	ra,28(sp)
 130:	01812403          	lw	s0,24(sp)
 134:	02010113          	addi	sp,sp,32
 138:	00008067          	ret

0000013c <delay>:
 13c:	fe010113          	addi	sp,sp,-32
 140:	00812e23          	sw	s0,28(sp)
 144:	02010413          	addi	s0,sp,32
 148:	fe042623          	sw	zero,-20(s0)
 14c:	0100006f          	j	15c <delay+0x20>
 150:	fec42783          	lw	a5,-20(s0)
 154:	00178793          	addi	a5,a5,1
 158:	fef42623          	sw	a5,-20(s0)
 15c:	fec42703          	lw	a4,-20(s0)
 160:	0000c7b7          	lui	a5,0xc
 164:	34f78793          	addi	a5,a5,847 # c34f <stack+0xa353>
 168:	fee7d4e3          	bge	a5,a4,150 <delay+0x14>
 16c:	00000013          	nop
 170:	01c12403          	lw	s0,28(sp)
 174:	02010113          	addi	sp,sp,32
 178:	00008067          	ret

0000017c <rx_read>:
 17c:	fe010113          	addi	sp,sp,-32
 180:	00812e23          	sw	s0,28(sp)
 184:	02010413          	addi	s0,sp,32
 188:	00000013          	nop
 18c:	000087b7          	lui	a5,0x8
 190:	06878793          	addi	a5,a5,104 # 8068 <stack+0x606c>
 194:	0007a783          	lw	a5,0(a5)
 198:	0027f713          	andi	a4,a5,2
 19c:	00200793          	li	a5,2
 1a0:	fef716e3          	bne	a4,a5,18c <rx_read+0x10>
 1a4:	000087b7          	lui	a5,0x8
 1a8:	06c78793          	addi	a5,a5,108 # 806c <stack+0x6070>
 1ac:	0007a783          	lw	a5,0(a5)
 1b0:	fef407a3          	sb	a5,-17(s0)
 1b4:	00000013          	nop
 1b8:	00078513          	mv	a0,a5
 1bc:	01c12403          	lw	s0,28(sp)
 1c0:	02010113          	addi	sp,sp,32
 1c4:	00008067          	ret

000001c8 <send_time>:
 1c8:	fd010113          	addi	sp,sp,-48
 1cc:	02112623          	sw	ra,44(sp)
 1d0:	02812423          	sw	s0,40(sp)
 1d4:	03010413          	addi	s0,sp,48
 1d8:	00050793          	mv	a5,a0
 1dc:	00058693          	mv	a3,a1
 1e0:	00060713          	mv	a4,a2
 1e4:	fcf40fa3          	sb	a5,-33(s0)
 1e8:	00068793          	mv	a5,a3
 1ec:	fcf40f23          	sb	a5,-34(s0)
 1f0:	00070793          	mv	a5,a4
 1f4:	fcf40ea3          	sb	a5,-35(s0)
 1f8:	fdf44783          	lbu	a5,-33(s0)
 1fc:	00a00593          	li	a1,10
 200:	00078513          	mv	a0,a5
 204:	240000ef          	jal	ra,444 <__udivsi3>
 208:	00050793          	mv	a5,a0
 20c:	0ff7f793          	andi	a5,a5,255
 210:	03078793          	addi	a5,a5,48
 214:	0ff7f793          	andi	a5,a5,255
 218:	fef40223          	sb	a5,-28(s0)
 21c:	fdf44783          	lbu	a5,-33(s0)
 220:	00a00593          	li	a1,10
 224:	00078513          	mv	a0,a5
 228:	264000ef          	jal	ra,48c <__umodsi3>
 22c:	00050793          	mv	a5,a0
 230:	0ff7f793          	andi	a5,a5,255
 234:	03078793          	addi	a5,a5,48
 238:	0ff7f793          	andi	a5,a5,255
 23c:	fef402a3          	sb	a5,-27(s0)
 240:	03a00793          	li	a5,58
 244:	fef40323          	sb	a5,-26(s0)
 248:	fde44783          	lbu	a5,-34(s0)
 24c:	00a00593          	li	a1,10
 250:	00078513          	mv	a0,a5
 254:	1f0000ef          	jal	ra,444 <__udivsi3>
 258:	00050793          	mv	a5,a0
 25c:	0ff7f793          	andi	a5,a5,255
 260:	03078793          	addi	a5,a5,48
 264:	0ff7f793          	andi	a5,a5,255
 268:	fef403a3          	sb	a5,-25(s0)
 26c:	fde44783          	lbu	a5,-34(s0)
 270:	00a00593          	li	a1,10
 274:	00078513          	mv	a0,a5
 278:	214000ef          	jal	ra,48c <__umodsi3>
 27c:	00050793          	mv	a5,a0
 280:	0ff7f793          	andi	a5,a5,255
 284:	03078793          	addi	a5,a5,48
 288:	0ff7f793          	andi	a5,a5,255
 28c:	fef40423          	sb	a5,-24(s0)
 290:	03a00793          	li	a5,58
 294:	fef404a3          	sb	a5,-23(s0)
 298:	fdd44783          	lbu	a5,-35(s0)
 29c:	00a00593          	li	a1,10
 2a0:	00078513          	mv	a0,a5
 2a4:	1a0000ef          	jal	ra,444 <__udivsi3>
 2a8:	00050793          	mv	a5,a0
 2ac:	0ff7f793          	andi	a5,a5,255
 2b0:	03078793          	addi	a5,a5,48
 2b4:	0ff7f793          	andi	a5,a5,255
 2b8:	fef40523          	sb	a5,-22(s0)
 2bc:	fdd44783          	lbu	a5,-35(s0)
 2c0:	00a00593          	li	a1,10
 2c4:	00078513          	mv	a0,a5
 2c8:	1c4000ef          	jal	ra,48c <__umodsi3>
 2cc:	00050793          	mv	a5,a0
 2d0:	0ff7f793          	andi	a5,a5,255
 2d4:	03078793          	addi	a5,a5,48
 2d8:	0ff7f793          	andi	a5,a5,255
 2dc:	fef405a3          	sb	a5,-21(s0)
 2e0:	fe040623          	sb	zero,-20(s0)
 2e4:	4f000513          	li	a0,1264
 2e8:	e05ff0ef          	jal	ra,ec <send_string>
 2ec:	fe440793          	addi	a5,s0,-28
 2f0:	00078513          	mv	a0,a5
 2f4:	df9ff0ef          	jal	ra,ec <send_string>
 2f8:	50400513          	li	a0,1284
 2fc:	df1ff0ef          	jal	ra,ec <send_string>
 300:	00000013          	nop
 304:	02c12083          	lw	ra,44(sp)
 308:	02812403          	lw	s0,40(sp)
 30c:	03010113          	addi	sp,sp,48
 310:	00008067          	ret

00000314 <main>:
 314:	f7010113          	addi	sp,sp,-144
 318:	08112623          	sw	ra,140(sp)
 31c:	08812423          	sw	s0,136(sp)
 320:	09010413          	addi	s0,sp,144
 324:	fe042223          	sw	zero,-28(s0)
 328:	000087b7          	lui	a5,0x8
 32c:	06478793          	addi	a5,a5,100 # 8064 <stack+0x6068>
 330:	00300713          	li	a4,3
 334:	00e7a023          	sw	a4,0(a5)
 338:	fe042623          	sw	zero,-20(s0)
 33c:	fe042423          	sw	zero,-24(s0)
 340:	000087b7          	lui	a5,0x8
 344:	00478793          	addi	a5,a5,4 # 8004 <stack+0x6008>
 348:	0007a783          	lw	a5,0(a5)
 34c:	0017f793          	andi	a5,a5,1
 350:	0a078063          	beqz	a5,3f0 <main+0xdc>
 354:	fec42783          	lw	a5,-20(s0)
 358:	02079063          	bnez	a5,378 <main+0x64>
 35c:	000087b7          	lui	a5,0x8
 360:	10c78793          	addi	a5,a5,268 # 810c <stack+0x6110>
 364:	0007a023          	sw	zero,0(a5)
 368:	fec42783          	lw	a5,-20(s0)
 36c:	00178793          	addi	a5,a5,1
 370:	fef42623          	sw	a5,-20(s0)
 374:	fcdff06f          	j	340 <main+0x2c>
 378:	000087b7          	lui	a5,0x8
 37c:	10478793          	addi	a5,a5,260 # 8104 <stack+0x6108>
 380:	0007c783          	lbu	a5,0(a5)
 384:	0ff7f793          	andi	a5,a5,255
 388:	00078513          	mv	a0,a5
 38c:	c85ff0ef          	jal	ra,10 <integer_to_bcd>
 390:	fea42023          	sw	a0,-32(s0)
 394:	000087b7          	lui	a5,0x8
 398:	10078793          	addi	a5,a5,256 # 8100 <stack+0x6104>
 39c:	0007c783          	lbu	a5,0(a5)
 3a0:	0ff7f793          	andi	a5,a5,255
 3a4:	00078513          	mv	a0,a5
 3a8:	c69ff0ef          	jal	ra,10 <integer_to_bcd>
 3ac:	fca42e23          	sw	a0,-36(s0)
 3b0:	fe042783          	lw	a5,-32(s0)
 3b4:	00879693          	slli	a3,a5,0x8
 3b8:	000087b7          	lui	a5,0x8
 3bc:	01078793          	addi	a5,a5,16 # 8010 <stack+0x6014>
 3c0:	fdc42703          	lw	a4,-36(s0)
 3c4:	00e68733          	add	a4,a3,a4
 3c8:	00e7a023          	sw	a4,0(a5)
 3cc:	000087b7          	lui	a5,0x8
 3d0:	10078793          	addi	a5,a5,256 # 8100 <stack+0x6104>
 3d4:	0007c783          	lbu	a5,0(a5)
 3d8:	0ff7f713          	andi	a4,a5,255
 3dc:	000087b7          	lui	a5,0x8
 3e0:	00e7a023          	sw	a4,0(a5) # 8000 <stack+0x6004>
 3e4:	fe042423          	sw	zero,-24(s0)
 3e8:	d55ff0ef          	jal	ra,13c <delay>
 3ec:	f55ff06f          	j	340 <main+0x2c>
 3f0:	fe042623          	sw	zero,-20(s0)
 3f4:	fe842783          	lw	a5,-24(s0)
 3f8:	f40794e3          	bnez	a5,340 <main+0x2c>
 3fc:	000087b7          	lui	a5,0x8
 400:	10478793          	addi	a5,a5,260 # 8104 <stack+0x6108>
 404:	0007c783          	lbu	a5,0(a5)
 408:	0ff7f713          	andi	a4,a5,255
 40c:	000087b7          	lui	a5,0x8
 410:	10078793          	addi	a5,a5,256 # 8100 <stack+0x6104>
 414:	0007c783          	lbu	a5,0(a5)
 418:	0ff7f793          	andi	a5,a5,255
 41c:	00078613          	mv	a2,a5
 420:	00070593          	mv	a1,a4
 424:	00000513          	li	a0,0
 428:	da1ff0ef          	jal	ra,1c8 <send_time>
 42c:	fe842783          	lw	a5,-24(s0)
 430:	00178793          	addi	a5,a5,1
 434:	fef42423          	sw	a5,-24(s0)
 438:	f09ff06f          	j	340 <main+0x2c>

0000043c <__divsi3>:
 43c:	06054063          	bltz	a0,49c <__umodsi3+0x10>
 440:	0605c663          	bltz	a1,4ac <__umodsi3+0x20>

00000444 <__udivsi3>:
 444:	00058613          	mv	a2,a1
 448:	00050593          	mv	a1,a0
 44c:	fff00513          	li	a0,-1
 450:	02060c63          	beqz	a2,488 <__udivsi3+0x44>
 454:	00100693          	li	a3,1
 458:	00b67a63          	bgeu	a2,a1,46c <__udivsi3+0x28>
 45c:	00c05863          	blez	a2,46c <__udivsi3+0x28>
 460:	00161613          	slli	a2,a2,0x1
 464:	00169693          	slli	a3,a3,0x1
 468:	feb66ae3          	bltu	a2,a1,45c <__udivsi3+0x18>
 46c:	00000513          	li	a0,0
 470:	00c5e663          	bltu	a1,a2,47c <__udivsi3+0x38>
 474:	40c585b3          	sub	a1,a1,a2
 478:	00d56533          	or	a0,a0,a3
 47c:	0016d693          	srli	a3,a3,0x1
 480:	00165613          	srli	a2,a2,0x1
 484:	fe0696e3          	bnez	a3,470 <__udivsi3+0x2c>
 488:	00008067          	ret

0000048c <__umodsi3>:
 48c:	00008293          	mv	t0,ra
 490:	fb5ff0ef          	jal	ra,444 <__udivsi3>
 494:	00058513          	mv	a0,a1
 498:	00028067          	jr	t0
 49c:	40a00533          	neg	a0,a0
 4a0:	0005d863          	bgez	a1,4b0 <__umodsi3+0x24>
 4a4:	40b005b3          	neg	a1,a1
 4a8:	f9dff06f          	j	444 <__udivsi3>
 4ac:	40b005b3          	neg	a1,a1
 4b0:	00008293          	mv	t0,ra
 4b4:	f91ff0ef          	jal	ra,444 <__udivsi3>
 4b8:	40a00533          	neg	a0,a0
 4bc:	00028067          	jr	t0

000004c0 <__modsi3>:
 4c0:	00008293          	mv	t0,ra
 4c4:	0005ca63          	bltz	a1,4d8 <__modsi3+0x18>
 4c8:	00054c63          	bltz	a0,4e0 <__modsi3+0x20>
 4cc:	f79ff0ef          	jal	ra,444 <__udivsi3>
 4d0:	00058513          	mv	a0,a1
 4d4:	00028067          	jr	t0
 4d8:	40b005b3          	neg	a1,a1
 4dc:	fe0558e3          	bgez	a0,4cc <__modsi3+0xc>
 4e0:	40a00533          	neg	a0,a0
 4e4:	f61ff0ef          	jal	ra,444 <__udivsi3>
 4e8:	40b00533          	neg	a0,a1
 4ec:	00028067          	jr	t0
