Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F52C11CA;
	Sun,  2 Aug 2026 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785690196; cv=none; b=HPuMPW6ItdCOClC1bJY6dr9KVMtn3gTyeyHcPMrcr0GGBagyQY61Vv3LJ6+kXiUUqLOlGcKJSQE6EJ+L3uDbDBwcxiOKAP50Z7fkwiAcxr7gpa7xT1bfuS02/aPWGduKGulRfiHn9t89NLm7B/VtyopLrUR42KvSNUGXMNYLR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785690196; c=relaxed/simple;
	bh=zDjgMYsSM67rwBm06O+xUeytwHah7ZueYsiVkGdndKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVpN79ox78a7BIGCzm/6hvP3ejD561b2xoDrC/U5k0ZW7dNSy/p9Wfs/1gBxqHnSL/ShnDOm4jOTy2+egXPYQBj2xLOlVok6mb4SsKUtFAFXr5MKDzPQYpuws1GC/NRmj0KlaMtCI/ix0qe4KUBFSNPRquB435E8nowvJvrYpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JClkKLL+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JClkKLL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC771F00A3A;
	Sun,  2 Aug 2026 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785690194;
	bh=yAbPfDbsNXYKFbJpkHtynyiXO4tpZHmVCigjm5J9Qtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JClkKLL+42YgAw81yxXBrBFY8ElECkBPq7UQlcWKUs8njJK+ILRIQyDwjl8uZyXZZ
	 mbDrFq8+YuesBNMtRfR2X9RSfi63dBhvZlkeBQ1JtZNHc6skLeNdy482G5SozPBRlS
	 BJ/co2qJdhBKKSz4nDo4Hp/WVwH80csLaa2WnOTejfTrFDAFe/LYCfvLDarCqjhAuv
	 9hZYbVhZZ7j1RdphBbDDogltTfRLxuKur2iLo0uNGtZbssKL5WZP3maq+6966mLjL7
	 jphRY1WpLCKK/YbCprTW34Oaae0CavknV1TGBU7xN8cvqzzMWv7/JTAtDs7tGoeeM1
	 bUMJb66s/HIkQ==
Date: Sun, 2 Aug 2026 18:03:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Adi Nata <adinata.softwareengineer@gmail.com>, nuno.sa@analog.com,
 andy@kernel.org, u.kleine-koenig@baylibre.com, mazziesaccount@gmail.com,
 bhelgaas@google.com, o-takashi@sakamocchi.jp, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: htc100c: Fix checkpatch warn unnecessary
 else
Message-ID: <20260802180310.78201b95@jic23-huawei>
In-Reply-To: <f8670ea5-1e76-4a04-9c5e-e43ffac92be0@baylibre.com>
References: <20260802014417.15485-1-adinata.softwareengineer@gmail.com>
	<f8670ea5-1e76-4a04-9c5e-e43ffac92be0@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 09:48:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/1/26 8:44 PM, Adi Nata wrote:
> > Checkpatch warning:  
> 
> Making checkpatch happy is not a good reason for a change on it's own.
> It is only there for guidance. It is not a strict rule that has to be
> followed.
> 
> I think this is a good change because it reduces duplication of the
> return statements and eliminates an unreachable break statement. So
> write the commit message with that reasoning and don't mention checkpatch.

A 'whilst I was looking at this code' comment below if you want to take
on an additional minor readability improvement.  Whilst it is a bit
churn heavy given touching most of the code you are changing here, I think
it would still need to be a separate follow on patch.  Also do check my
suggestion carefully as I may have missed something!

thanks,

Jonathan
> 
> > 
> > WARNING:UNNECESSARY_ELSE: else is not generally useful after a break or return
> > +			return IIO_VAL_FRACTIONAL;
> > +		} else {
> > 
> > Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> > ---
> >  drivers/iio/humidity/hdc100x.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > index bc452cc8fbcf..38903239fb9a 100644
> > --- a/drivers/iio/humidity/hdc100x.c
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -229,13 +229,11 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
> >  		if (chan->type == IIO_TEMP) {
> >  			*val = 165000;
> >  			*val2 = 65536;
A whilst we are here comment.

This is 2**16  So maybe can use chan->real_bits
to provide a form of documentation of where it comes from and
then return IIO_VAL_FRACTIONAL_LOG2;


> > -			return IIO_VAL_FRACTIONAL;
> >  		} else {
> >  			*val = 100000;
> >  			*val2 = 65536;
> > -			return IIO_VAL_FRACTIONAL;
> >  		}
> > -		break;
> > +		return IIO_VAL_FRACTIONAL;
> >  	case IIO_CHAN_INFO_OFFSET:
> >  		*val = -15887;
> >  		*val2 = 515151;  
> 

