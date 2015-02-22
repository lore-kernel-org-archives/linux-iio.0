Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:53929 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbBVKo4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Feb 2015 05:44:56 -0500
MIME-Version: 1.0
In-Reply-To: <54B109F0.5060101@kernel.org>
References: <1417563176-31972-1-git-send-email-richard@nod.at>
	<54A53FBF.5000003@kernel.org>
	<7e4f6a70e48afe96457ebbcf07572224@imap.cosmopool.net>
	<54A680F8.30209@nod.at>
	<54A91DA1.6080107@kernel.org>
	<E1Y881p-0001Fp-NX@stardust.g4.wien.funkfeuer.at>
	<54AA97B9.7040703@nod.at>
	<E1Y8pZ9-000133-AF@stardust.g4.wien.funkfeuer.at>
	<54B109F0.5060101@kernel.org>
Date: Sun, 22 Feb 2015 11:44:55 +0100
Message-ID: <CAFLxGvw09BN+Nrq2qEt-a=XndYKYF6HzdEgZswYxrzRqUm9ebw@mail.gmail.com>
Subject: Re: [PATCHv2 2/3,RESEND] iio: dht11: Add locking
From: Richard Weinberger <richard.weinberger@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Harald Geyer <harald@ccbib.org>,
	Richard Weinberger <richard@nod.at>, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>, pmeerw@pmeerw.net,
	sanjeev_sharma@mentor.com, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jan 10, 2015 at 12:16 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 07/01/15 12:18, Harald Geyer wrote:
>> Make sure that the read function is not interrupted...
>>
>> From: Richard Weinberger <richard@nod.at>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> Acked-by: Harald Geyer <harald@ccbib.org>
>> Reviewed-by: Sanjeev Sharma <sanjeev_sharma@mentor.com>
>> ---
>> Resending again to get the metadata right.
>> No Signed-off-by from me, because I didn't contribute anything.
> Technically you 'handled' the patch which is all that actually
> matters for a sign-off.  Anyhow I don't really care either way ;)
>
> Applied to the fixes-togreg branch of iio.git

I don't see any of my fixes in Linus' tree.
Did I miss something?

-- 
Thanks,
//richard
