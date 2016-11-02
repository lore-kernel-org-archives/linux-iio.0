Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:47762 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753287AbcKBQVi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Nov 2016 12:21:38 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 6D304208D3
        for <linux-iio@vger.kernel.org>; Wed,  2 Nov 2016 17:21:35 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 02 Nov 2016 17:21:33 +0100
From: Martin Kepplinger <martink@posteo.de>
To: Mani Sadhasivam <manivannanece23@gmail.com>
Cc: pmeerw@pmeerw.net, Linux iio <linux-iio@vger.kernel.org>
Subject: Re: TODO task for MMA8452 Accelerometer
In-Reply-To: <20161102155018.GA5226@mani-Aspire-E5-573>
References: <20161102155018.GA5226@mani-Aspire-E5-573>
Message-ID: <63782e413b8555efededc2bd2f1ccf69@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 02.11.2016 16:50 schrieb Mani Sadhasivam:
> Hi Martin/Peter,
Hi Mani,

It'd be nice to keep a relevant public list in CC, in this case 
linux-iio or kernelnewbies

> 
> This is Mani, working on MMA8452 Accelerometer with Beaglebone black.
> I just wanna know whether the TODO : 'Orientation events' task for
> this Accelerometer is undergoing or not. If not, can I work on the
> same under your mentoring.

It's not done and not being worked on (afaik).

> 
> For your kind info, I'm a recent undergraduate working in a Product
> development company called MathWorks. I'm learning Linux Kernel
> development as a hobby. Also, I thought taking up this task would be a
> good starting point for Linux Kernel Development.

I doubt this is a very good first task. iirc, you'd have to work with 
with Jon, Daniel, Peter ... on an interface first. This is no gyrosensor 
where iio has a proper user interface for orientation. That means, 
coming up with your own, to discuss, and have example implementations 
ready.

> 
> If this task is already done, kindly suggest me a task to help me get
> involved with Linux community.

This mma8452 driver supports a few devices. Which one do you have? 
Depending on that, I may have a simpler task for you.

> 
> Please share your views.
> 
> Thanks,
> Mani.
