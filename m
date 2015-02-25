Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37299 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbbBYUnu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Feb 2015 15:43:50 -0500
Message-ID: <54EDB987.5070807@kernel.org>
Date: Wed, 25 Feb 2015 12:01:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Richard Weinberger <richard.weinberger@gmail.com>
CC: Harald Geyer <harald@ccbib.org>,
	Richard Weinberger <richard@nod.at>, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>, pmeerw@pmeerw.net,
	sanjeev_sharma@mentor.com, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 2/3,RESEND] iio: dht11: Add locking
References: <1417563176-31972-1-git-send-email-richard@nod.at>	<54A53FBF.5000003@kernel.org>	<7e4f6a70e48afe96457ebbcf07572224@imap.cosmopool.net>	<54A680F8.30209@nod.at>	<54A91DA1.6080107@kernel.org>	<E1Y881p-0001Fp-NX@stardust.g4.wien.funkfeuer.at>	<54AA97B9.7040703@nod.at>	<E1Y8pZ9-000133-AF@stardust.g4.wien.funkfeuer.at>	<54B109F0.5060101@kernel.org> <CAFLxGvw09BN+Nrq2qEt-a=XndYKYF6HzdEgZswYxrzRqUm9ebw@mail.gmail.com>
In-Reply-To: <CAFLxGvw09BN+Nrq2qEt-a=XndYKYF6HzdEgZswYxrzRqUm9ebw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/02/15 10:44, Richard Weinberger wrote:
> On Sat, Jan 10, 2015 at 12:16 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 07/01/15 12:18, Harald Geyer wrote:
>>> Make sure that the read function is not interrupted...
>>>
>>> From: Richard Weinberger <richard@nod.at>
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> Acked-by: Harald Geyer <harald@ccbib.org>
>>> Reviewed-by: Sanjeev Sharma <sanjeev_sharma@mentor.com>
>>> ---
>>> Resending again to get the metadata right.
>>> No Signed-off-by from me, because I didn't contribute anything.
>> Technically you 'handled' the patch which is all that actually
>> matters for a sign-off.  Anyhow I don't really care either way ;)
>>
>> Applied to the fixes-togreg branch of iio.git
> 
> I don't see any of my fixes in Linus' tree.
> Did I miss something?
> 
Timing was unfortunate for these.  It's messy to send
fixes very close to the end of a cycle for anything less
than high impact bugs (Greg KH won't send them on to Linus).
Then the merge window and now I'm in a clean room without my ssh
keys.  Hence these will go to Greg soon, but haven't just yet.
Quite a few other fixes queued up along side yours.

Sorry for the delay.

Jonathan
