Return-Path: <SRS0=jBoM=QI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320A6C282D8
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 11:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B03521904
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 11:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfBALSB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:18:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfBALSB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Feb 2019 06:18:01 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 65878BAED409594B282F
        for <linux-iio@vger.kernel.org>; Fri,  1 Feb 2019 19:17:59 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 19:17:55 +0800
Date:   Fri, 1 Feb 2019 11:17:47 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     "Medenblik, H.J.W. (Henk)" <henk.medenblik@tno.nl>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Some thoughts on metadata and iio
Message-ID: <20190201111747.000020ba@huawei.com>
In-Reply-To: <ea0d80d50a7146e8b09e6f1e19aa614d@tno.nl>
References: <ea0d80d50a7146e8b09e6f1e19aa614d@tno.nl>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 31 Jan 2019 20:16:01 +0000
"Medenblik, H.J.W. (Henk)" <henk.medenblik@tno.nl> wrote:

> Dear IIO supporters,
Hi Henk,

> 
> I have been struggling for a while with the lack of metadata support
> inside the IIO framework. I really appreciate all the tremendous work
> that has been done to extend the iio framework to a very useful
> subsystem which easily can be used to acquire fast data streams inside
> Linux.
> 
> I have been able to implement complete FPGA systems with high datarate
> devices connected and store that info to Solid State Drives or transfer
> that data over the network at high speeds (thanks Analog Devices).
> However, what I have been missing so far is some feature which allows me
> to add metadata to these streams. I was mostly focused on what is
> currently available right now and tried to understand and adapt to these
> thought and 'common' practices in order to see if I was something
> missing how to handle this issue of using metadata inside the IIO
> framework or if someone already designed that before within the framework.
> 
> I believe there are many real world application examples where somebody
> need adding metadata into the 'standard' datastreams such as ADC or DAC
> data samples. The metadata that I needed to have inserted was also very
> timing critical and also changing in a time critical manner, which I
> believe that it could only be inserted and triggered within my HDL
> hardware design. So i did.....
> 
> My solution therefore was to define a customized metadata header (custom
> size) generated inside my HDL design. I also decided to make the size of
> this header a multiple of the elementary data sample size such that I
> would not get any alignment problems when acquiring data from my
> backend. Whenever I now retrieve data from my fpga backend with custom
> iio device I can get all the data that I want including the meta header.
> 
> With this 'solution' I was wondering if it would make sense if the
> current framework would be extended with additional iio information
> describing the iio device. Currently there are so many properties
> defining the samples inside iio such as if it is voltage or light or
> whatever.. Why not add something which indicates if the device has
> metadata support or not by defining a dedicated property for it. A
> second parameter could describe the size of the metadata header. The
> combination of the two parameter extensions can then be used to help the
> user software to identify positions of where the real data samples start
> inside the stream.

My main concerns are around the fact that one of the fundamental elements
of IIO is that it always assumes a fixed size 'scan'.  I don't 'like'
putting meta data in there for the majority of devices as people will be
inclined to use this for convenience and it makes userspace much more complex
(i.e. meta data basically gets thrown away by all 'standard' userspace code
as it is often device / application specific in a way that cannot be easily
encoded). However, I appreciate there are cases where there is basically
no alternative.

The issue with inserting meta data sometimes, which I think you are talking
about is that it blocks lots of standard processing techniques because you have
to walk the whole dataset to know where the actual data is. You can't do
random access.  Sure in your usecase this might not be a problem, but for
some cases it is a deal breaker.

Of course there are ways around this via indirection and we could explore
that potentially.  So in that you'd have the data embed a fixed length
code in every scan which could then reference an entry in a separate meta
data stream.  Overhead is small in the main stream but we don't loose
the fixed length 'scan' advantages.  Also lets you do things like indicate
that the meta data is still valid (repeated value) or unknown (magic value).
Would something like that potentially work for you?

Jonathan
> 
> I am wondering if this makes sense.
> 
> With kind regards,
> 
> Henk
> 
> 
> This message may contain information that is not intended for you. If you are not the addressee or if this message was sent to you by mistake, you are requested to inform the sender and delete the message. TNO accepts no liability for the content of this e-mail, for the manner in which you use it and for damage of any kind resulting from the risks inherent to the electronic transmission of messages.
> 


