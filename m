Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38965 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHTUf2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Aug 2018 16:35:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so7085961pff.6
        for <linux-iio@vger.kernel.org>; Mon, 20 Aug 2018 10:18:59 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] iio: chemical: bme680: use clamp macro
To: Jonathan Cameron <jic23@kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>
Cc: linux-iio@vger.kernel.org
References: <20180817190319.13119-1-dpfrey@gmail.com>
 <20180817190319.13119-2-dpfrey@gmail.com>
 <20180818110323.GB24920@himanshu-Vostro-3559>
 <20180819164706.4eab1634@archlinux>
From: David Frey <dpfrey@gmail.com>
Message-ID: <8f7def1e-97d7-b8b4-bc5d-09d9478998f6@gmail.com>
Date: Mon, 20 Aug 2018 10:18:54 -0700
MIME-Version: 1.0
In-Reply-To: <20180819164706.4eab1634@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 8/19/2018 8:47 AM, Jonathan Cameron wrote:
> On Sat, 18 Aug 2018 16:33:23 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
>> On Fri, Aug 17, 2018 at 12:03:13PM -0700, David Frey wrote:
>>> Signed-off-by: David Frey <dpfrey@gmail.com>  
>>
>> Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
>> Tested-by: Himanshu Jha <himanshujha199640@gmail.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

Hi,

I'm trying to understand the linux-iio mailing list workflow a bit
better.  I have
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git as my "iio"
remote in my Linux kernel repository.  From that remote, I can see
remotes/iio/togreg.  When I do a "git fetch", the togreg branch hasn't
been updated.  Did Jonathan mean that he applied the patch to the togreg
branch in his local repository, but hasn't yet pushed it to the one that
I have listed above?  Are the "autobuilders" specific to IIO?  Is this
infrastructure publicly accessible or is it only available to specific
users?  If it's public, where can I view it/learn more about it?

Thanks,
David
