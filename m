Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752460AbeDORuc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 13:50:32 -0400
Date: Sun, 15 Apr 2018 18:50:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <mkelly@xevo.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio:imu: inv_mpu6050: support more interrupt
 types
Message-ID: <20180415185027.62a74e05@archlinux>
In-Reply-To: <faa41264-5063-541a-32cd-976930769ee9@xevo.com>
References: <20180409202128.5031-1-mkelly@xevo.com>
        <64b0a5c7-ee8d-d1ca-b3aa-a1801f19787c@invensense.com>
        <6e3f08f8-ec16-e67b-c68c-7020eb660b14@xevo.com>
        <2ab59fc6-49c9-7426-fe95-824a165cfefa@invensense.com>
        <ef871439-f42f-cb7d-6dc3-4e0c47ff8986@xevo.com>
        <3b0b5ed8-f224-e589-ce60-e1871e76b25a@invensense.com>
        <67000b98-7db9-f16e-d468-bc688cc56342@xevo.com>
        <3941609e-c75d-2a47-8b33-a7a5e4131741@invensense.com>
        <faa41264-5063-541a-32cd-976930769ee9@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 09:19:41 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> On 04/13/2018 02:25 AM, Jean-Baptiste Maneyrol wrote:
> > Hello,
> > 
> > I am now able to reproduce the issue by generating kernel irq (just 
> > plug/unplug mouse or keyboard is sufficient).
> > 
> > My last modification doesn't solve anything, since event the hard irq 
> > handler is disabled when processing another interrupt. Having a latched 
> > interrupt and triggering by level is a workaround, but clearly not perfect.
> >   
> 
> 
> I'm glad you can reproduce the issue now! What board are you using? My 
> issues have been with the nanopi neo air (based on the Allwinner H3 SoC).
> 
> > I think we need to work out a new solution for timestamping correctly 
> > the data.
> > 
> > JB
> > 
> >  
> I think we should try to solve the missing interrupts issue. Without 
> solving it, the best we can do is interpolate, as I do in the other patch.
> 
> That said, I think supporting more interrupt types and interpolating are 
> good ideas regardless. Supporting more interrupt types is useful for 
> integrating with more types of hardware, and interpolating is useful for 
> being more robust against systems having issues, which can unexpectedly 
> happen even if we fix the immediate issue we see here.
Agreed on the interrupt types.  Interpolating is till rather 'nasty'
so the case is a little less clear, but I'm being convinced I think...

Anyhow, looking forward to v6  Will want JB reviewed-by or acked-by
on this one!

Jonathan


