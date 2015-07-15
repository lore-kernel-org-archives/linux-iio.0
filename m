Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:34468 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751987AbbGOP63 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 15 Jul 2015 11:58:29 -0400
Message-ID: <55A682F8.3090001@ni.com>
Date: Wed, 15 Jul 2015 10:57:44 -0500
From: Xander Huff <xander.huff@ni.com>
MIME-Version: 1.0
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
CC: jic23@kernel.org, bigeasy@linutronix.de, lars@metafoo.de,
	nathan.sullivan@ni.com, linux-rt-users@vger.kernel.org,
	linux-iio@vger.kernel.org, jaeden.amero@ni.com, joshc@ni.com,
	michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
	joe.hershberger@ni.com, linux-arm-kernel@lists.infradead.org,
	pmeerw@pmeerw.net, knaack.h@gmx.de, soren.brinkmann@xilinx.com
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
References: <5574633F.7090004@kernel.org>	<1436391502-2604-1-git-send-email-xander.huff@ni.com> <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
In-Reply-To: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 7/9/2015 12:03 AM, Shubhrajyoti Datta wrote:
>     @@ -330,8 +310,18 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq,
>     void *devid)
>                      xadc_zynq_update_intmsk(xadc, 0, 0);
>                      ret = IRQ_WAKE_THREAD;
>              }
>     +
>     +       alarm = xadc->zynq_alarm;
>     +       xadc->zynq_alarm = 0;
>     +
>              spin_unlock(&xadc->lock);
>
>     +       xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(alarm));
>     +
>     +       /* unmask the required interrupts in timer. */
>     +       schedule_delayed_work(&xadc->zynq_unmask_work,
>     +                       msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
>     +
>
> Now that we are in the threaded context do we need the  work queue stuff.
Seems reasonable to try to remove it. I'll do some testing and send out a v3 if 
it works, thanks.

-- 
Xander Huff
Staff Software Engineer
National Instruments
