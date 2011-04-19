Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:35914 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab1DSPkn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Apr 2011 11:40:43 -0400
Message-ID: <4DADAD72.9070701@cam.ac.uk>
Date: Tue, 19 Apr 2011 16:42:42 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio_trigger_poll_chained causes NULL pointer access
References: <544AC56F16B56944AEC3BD4E3D591771375475ED44@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771375475ED44@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/19/11 16:22, Hennerich, Michael wrote:
> Hi Jonathan,
> 
> The AD7606 ring buffer doesn't use the thread, and installs only the hard handler.
> 
>         indio_dev->pollfunc->h = &ad7606_trigger_handler_th;
>         indio_dev->pollfunc->thread = NULL;
> 
> This crashes the system in handle_nested_irq (null pointer action->thread_fn)
> called from iio_trigger_poll_chained().
I knew that wouldn't work, but didn't realize it wouldn't just fail with
an error...

The only thing I can think to do is to actually set both h and thread
to ad7606_trigger_handler_th.

As it returns IRQ_HANDLED, if it is called via irq_trigger_poll, it will
happen in interrupt context and thread will never run.

If it is called via irq_trigger_poll_handler (e.g. for non interrupt context)
it'll happen outside interrupt context. Given timing is never going to
be that tight for userspace triggers, this probably isn't a problem.

Can you try that out and see if it works?
> 
> root:/> echo 1 > /sys/bus/iio/devices/trigger0/trigger_now
> Jump to NULL address
> Kernel OOPS in progress
> Deferred Exception context
> CURRENT PROCESS:
> COMM=sh PID=166  CPU=0
> TEXT = 0x02a00040-0x02a54380        DATA = 0x02a543a0-0x02a68d28
>  BSS = 0x02a68d28-0x02a6a6e0  USER-STACK = 0x02a73fa4
> 
> return address: [0x  (null)]; contents of:
> 
> ADSP-BF537-0.2 500(MHz CCLK) 125(MHz SCLK) (mpu off)
> Linux version 2.6.39-rc3-00802-g1f36cb3-dirty (michael@mhenneri-D02) (gcc version 4.3.5 (ADI-trunk/svn-5074) ) #84 Tue Apr 19 17:09:10 CEST 2011
> 
> SEQUENCER STATUS:               Not tainted
>  SEQSTAT: 0000002d  IPEND: 8008  IMASK: ffff  SYSCFG: 0006
>   EXCAUSE   : 0x2d
>   physical IVG3 asserted : <0xffa007b4> { _trap + 0x0 }
>   physical IVG15 asserted : <0xffa01098> { _evt_system_call + 0x0 }
>   logical irq   6 mapped  : <0xffa003c8> { _bfin_coretmr_interrupt + 0x0 }
>   logical irq  10 mapped  : <0x000c0278> { _bfin_rtc_interrupt + 0x0 }
>   logical irq  16 mapped  : <0x000c2114> { _bfin_twi_interrupt_entry + 0x0 }
>   logical irq  18 mapped  : <0x000ab53c> { _bfin_serial_dma_rx_int + 0x0 }
>   logical irq  19 mapped  : <0x000ab29c> { _bfin_serial_dma_tx_int + 0x0 }
>   logical irq  24 mapped  : <0x000baa40> { _bfin_mac_interrupt + 0x0 }
>   logical irq  54 mapped  : <0x000cce0c> { _ad7606_interrupt + 0x0 }
>   logical irq 106 mapped  : <0x000cd390> { _ad7606_trigger_handler_th + 0x0 }
>  RETE: <0x00000000> /* Maybe null pointer? */
>  RETN: <0x028f7e3c> /* kernel dynamic memory (maybe user-space) */
>  RETX: <0x00000480> /* Maybe fixed code section */
>  RETS: <0x00036778> { _handle_nested_irq + 0x58 }
>  PC  : <0x00000000> /* Maybe null pointer? */
> DCPLB_FAULT_ADDR: <0x028e71f4> /* kernel dynamic memory (maybe user-space) */
> ICPLB_FAULT_ADDR: <0x00000000> /* Maybe null pointer? */
> PROCESSOR STATE:
>  R0 : 0000006a    R1 : 027f8c80    R2 : 00000000    R3 : 028dc3c4
>  R4 : 026cf860    R5 : 028e77b4    R6 : 00000002    R7 : 0000006a
>  P0 : 02078002    P1 : 00000089    P2 : 00000000    P3 : 00130080
>  P4 : 00195efc    P5 : 0019b488    FP : 028f7ef0    SP : 028f7d60
>  LB0: ffa01778    LT0: ffa01776    LC0: 00000000
>  LB1: 02a0cfdd    LT1: 02a0cf92    LC1: 00000000
>  B0 : 00000001    L0 : 00000000    M0 : 0000002c    I0 : 00195efc
>  B1 : 00000001    L1 : 00000000    M1 : 00000001    I1 : 02a73d88
>  B2 : 02a739c3    L2 : 00000000    M2 : 00000000    I2 : 02a68a20
>  B3 : 00000001    L3 : 00000000    M3 : 00000000    I3 : 00000000
> A0.w: 00000000   A0.x: 00000000   A1.w: 00000000   A1.x: 00000000
> USP : 02a73d10  ASTAT: 02000020
> 
> Hardware Trace:
>    0 Target : <0x00003fa8> { _trap_c + 0x0 }
>      Source : <0xffa00748> { _exception_to_level5 + 0xa4 } JUMP.L
>    1 Target : <0xffa006a4> { _exception_to_level5 + 0x0 }
>      Source : <0xffa00558> { _bfin_return_from_exception + 0x20 } RTX
>    2 Target : <0xffa00538> { _bfin_return_from_exception + 0x0 }
>      Source : <0xffa005fc> { _ex_trap_c + 0x74 } JUMP.S
>    3 Target : <0xffa00588> { _ex_trap_c + 0x0 }
>      Source : <0xffa0081c> { _trap + 0x68 } JUMP (P4)
>    4 Target : <0xffa007d2> { _trap + 0x1e }
>      Source : <0xffa007ce> { _trap + 0x1a } IF CC JUMP pcrel
>    5 Target : <0xffa007b4> { _trap + 0x0 }
>       FAULT : <0x00000000> /* Maybe null pointer? */
>      Source : <0x00036776> { _handle_nested_irq + 0x56 } CALL (P2)
>    6 Target : <0x00036732> { _handle_nested_irq + 0x12 }
>      Source : <0xffa0214c> { __cond_resched + 0x20 } RTS
>    7 Target : <0xffa02146> { __cond_resched + 0x1a }
>      Source : <0xffa0213e> { __cond_resched + 0x12 } IF CC JUMP pcrel (BP)
>    8 Target : <0xffa0212c> { __cond_resched + 0x0 }
>      Source : <0x0003672e> { _handle_nested_irq + 0xe } JUMP.L
>    9 Target : <0x0003672c> { _handle_nested_irq + 0xc }
>      Source : <0x000348e6> { _irq_to_desc + 0x1a } RTS
>   10 Target : <0x000348cc> { _irq_to_desc + 0x0 }
>      Source : <0x00036728> { _handle_nested_irq + 0x8 } JUMP.L
>   11 Target : <0x00036720> { _handle_nested_irq + 0x0 }
>      Source : <0x000cbd2c> { _iio_trigger_poll_chained + 0x58 } JUMP.L
>   12 Target : <0x000cbd22> { _iio_trigger_poll_chained + 0x4e }
>      Source : <0x000cbcf0> { _iio_trigger_poll_chained + 0x1c } IF !CC JUMP pcrel
>   13 Target : <0x000cbcd4> { _iio_trigger_poll_chained + 0x0 }
>      Source : <0x000cd518> { _iio_sysfs_trigger_poll + 0xc } CALL pcrel
>   14 Target : <0x000cd514> { _iio_sysfs_trigger_poll + 0x8 }
>      Source : <0x000afdf2> { _dev_get_drvdata + 0x16 } RTS
>   15 Target : <0x000afde6> { _dev_get_drvdata + 0xa }
>      Source : <0x000afde0> { _dev_get_drvdata + 0x4 } IF !CC JUMP pcrel
> Kernel Stack
> Stack info:
>  SP: [0x028f7f24] <0x028f7f24> /* kernel dynamic memory (maybe user-space) */
>  Memory from 0x028f7f20 to 028f8000
> 028f7f20: 7fffffff [02a039de]
>  00000000  00000000  028f8000  02a039de  02a039de
> 028f7f40: 02a158ea  ffa010fc  02001004  02a0cfdd  02a0cdcd  02a0cf92  02a0cdca  00000000
> 028f7f60: 00000000  00000000  00000000  00000000  00000000  00000001  02a739c3  00000001
> 028f7f80: 00000001  00000000  00000000  00000000  00000000  00000000  00000000  00000001
> 028f7fa0: 00000000  00000000  02a68a20  02a73d88  029ea578  02a73d10  02a73d1c  02a695c8
> 028f7fc0: 02a6870c  02a73d94  02a695ca  02a6870c  00000004  00000002  00000002  7fffffff
> 028f7fe0: 00000000  00000000  00000002  02a695c8  00000001  00000001  00000004  00000006
> Return addresses in stack:
>     address : <0x00008000> { _show_regs + 0x154 }
> Modules linked in:
> Kernel panic - not syncing: Kernel exception
> Hardware Trace:
> Stack info:
>  SP: [0x028f7c68] <0x028f7c68> /* kernel dynamic memory (maybe user-space) */
>  FP: (0x028f7d78)
>  Memory from 0x028f7c60 to 028f8000
> 028f7c60: 028f7c68  00000013 [00155970] 00124660  028f7d60  00155970  001893cb  001893cb
> 028f7c80: 001893cb  028f7cb0  028f7ef0  00004464  028f7d60  ffe02014  00130080  00008008
> 028f7ca0: 0000000b  0000002d  00000013  028f7d60  0000003f  ffffffff  0007e710  00000000
> 028f7cc0: 0003000b  0005bd68  0000a068  028dc3c4  028f7ec4  01a02a64  00000001  00000000
> 028f7ce0: 00000000  00000000  028f7ec4  0005bc60  02a9d8cc  02a96b54  02a9d8cc  00000002
> 028f7d00: 0000a068  00000000  00000008  00051b04  00000002  02a9d8cc  00000002  00000000
> 028f7d20: 00000000  0004aace  02a96b54  028f7e34  0000002c  00000000  001a38e4  ffa0074c
> 028f7d40: 00186000  00008008  0000002d  028e77b4  026cf860  009c5234  00000001  00000480
> 028f7d60: 00000480  00008008  0000002d  00000000  028f7e3c  00000480 (00000000)
> 028f7d80: 0000006a  02000020  02a0cfdd  ffa01778  02a0cf92  ffa01776  00000000  00000000
> 028f7da0: 00000000  00000000  00000000  00000000  00000001  02a739c3  00000001  00000001
> 028f7dc0: 00000000  00000000  00000000  00000000  00000000  00000000  00000001  0000002c
> 028f7de0: 00000000  02a68a20  02a73d88  00195efc  02a73d10  028f7ef0  0019b488  00195efc
> 028f7e00: 00130080  00000000  00000089  02078002  0000006a  00000002  028e77b4  026cf860
> 028f7e20: 028dc3c4  00000000  027f8c80  0000006a  0000006a  02078002  00000006  a92f6ddb
> 028f7e40: 001a38c0  028f7ef0  000cbd30  029a0200  028dc3c4  029a0210  00000000  00000002
> 028f7e60: 028e77b4  000cd51c  028e77a0  00000000  0007eabc  029a0210 <0007eb30> 00000000
> 028f7e80: 00000000  00000000  00000002  02a73d1c <0004baa6> 026cf860  00000004  02a73d94
> 028f7ea0: 028f7ef0  00000002  02a695c8  00000000  00000004  00000000  02a73d7c  028f7ef0
> 028f7ec0: 026cf860  00000006  0004bbbc  026cf860  00000004  02a695c8  00000002  7fffffff
> 028f7ee0: 026cf860  00000001  00000000  028f7ef0  00000000  00000000  00000000 <ffa00956>
> 028f7f00: 0004bb8c  00000000  ffffe000  ffffe000  7fffffff  0000fffe  00000000  00000000
> 028f7f20: 7fffffff  02a039de
>  00000000  00000000  028f8000  02a039de  02a039de
> 028f7f40: 02a158ea  ffa010fc  02001004  02a0cfdd  02a0cdcd  02a0cf92  02a0cdca  00000000
> 028f7f60: 00000000  00000000  00000000  00000000  00000000  00000001  02a739c3  00000001
> 028f7f80: 00000001  00000000  00000000  00000000  00000000  00000000  00000000  00000001
> 028f7fa0: 00000000  00000000  02a68a20  02a73d88  029ea578  02a73d10  02a73d1c  02a695c8
> 028f7fc0: 02a6870c  02a73d94  02a695ca  02a6870c  00000004  00000002  00000002  7fffffff
> 028f7fe0: 00000000  00000000  00000002  02a695c8  00000001  00000001  00000004  00000006
> Return addresses in stack:
>    frame  1 : <0x00036778> { _handle_nested_irq + 0x58 }
>     address : <0x0007eb30> { _sysfs_write_file + 0xac }
>     address : <0x0004baa6> { _vfs_write + 0x6a }
>     address : <0xffa00956> { _system_call + 0x6a }
>     address : <0x00008000> { _show_regs + 0x154 }
> 
> 
> ------------------------------------------------------------------
> ********* Analog Devices GmbH
> **  *****
> **     ** Wilhelm-Wagenfeld-Strasse 6
> **  ***** D-80807 Munich
> ********* Germany
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer: Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 

