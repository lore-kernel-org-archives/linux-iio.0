Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831522D47F1
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776004455; cv=none; b=eytNzEE7P3XuE1DFWs8YwtGgCcEddfmFP4GYYgnhJVcMP4mby7lZBtvHlz3vLnJ798+l2xExbLwlGkYfeDBznPRxCIdg5zeOzt6Dmsw7gfThWrO52IRTgWCMtTxrkTh5IMae8fLebCnFvIqSWmOntrLMU/n71yKONNedLApPvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776004455; c=relaxed/simple;
	bh=LKIOlXJQ9dkZ3cB/K/lt168j5QthpmS7AOiwKtSKH+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzPqNe2FPr9Eg27rFSMOhV+1l/fru38SNz09j9UBwJpp3u5DFuWTgZvRsuDt1VVb5cQIOqJvzI+d4zSdONODro73RzIcLW7VlVYI3mKVfH3XGPPgw/NnSRqxrFFpPGaKZWYSNL3KfGPnXXoC8VQ9+Mm+CpzywT2m3uFWu6PxZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpVDovK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpVDovK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33F7C19424;
	Sun, 12 Apr 2026 14:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776004455;
	bh=LKIOlXJQ9dkZ3cB/K/lt168j5QthpmS7AOiwKtSKH+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DpVDovK0JdyDiBpE2bqVvUtc6Xyx6GRnLpkADMg1ep7NZZu1728kx9MbosgBgBagJ
	 gFJzyx2TmuDl5ANEC8SEFg+Hty/cCQnPPnQxmRW6F93RRY/2trZ5v7HKgOLjOdNF7k
	 VM9rTpcjeyPLMq7BwXxKafAa83Jsj8WDtBDfUSRJsJzWoItNFrlToueZ6gsennRG/5
	 FFifdF+YRcUyWKkmjRgtpIGpRgA5iUnWeIhI2dMtBWxiutSzjkfyLVwTVR9m1s30Sg
	 1HncscspeP4A4XX6VHJ7vlIVc/9hfLZomqoC7LM/Avpo5ox9XRU1HGg627B7qDoUwz
	 Z4OKsySCgbwVQ==
Date: Sun, 12 Apr 2026 15:34:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Chuang Zhu <git@chuang.cz>, linux-iio@vger.kernel.org, Marc Titinger
 <mtitinger@baylibre.com>, Stefan =?UTF-8?B?QnLDvG5z?=
 <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v3] iio: adc: ina2xx: add INA236 support
Message-ID: <20260412153347.539c5eee@jic23-huawei>
In-Reply-To: <20260408155520.GA2256298-robh@kernel.org>
References: <20260315182304.613783-1-git@chuang.cz>
	<20260408155520.GA2256298-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Apr 2026 10:55:20 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Mar 16, 2026 at 02:23:04AM +0800, Chuang Zhu wrote:
> > The calibration divisor is not directly specified in the datasheet, but can be calculated:
> > 
> > I = Current_LSB * Current
> > Current = ShuntVoltage * CAL / calibration_divisor
> > CAL = 0.00512 / (Current_LSB * Rshunt)
> > ShuntVoltage = Vshunt / ShuntVoltage_LSB
> >   
> > => I = (0.00512 / (calibration_divisor*ShuntVoltage_LSB)) * (Vshunt / Rshunt)  
> > 
> > Ohm's law, I = Vshunt / Rshunt  
> > => 0.00512 / (calibration_divisor*ShuntVoltage_LSB) = 1  
> > 
> > ShuntVoltage_LSB = 2.5 uV = 0.0000025 V  
> > => calibration_divisor = 2048  
> > 
> > Signed-off-by: Chuang Zhu <git@chuang.cz>  
> 
> 
> > @@ -1082,6 +1117,10 @@ static const struct of_device_id ina2xx_of_match[] = {
> >  		.compatible = "ti,ina231",
> >  		.data = (void *)ina226
> >  	},
> > +	{
> > +		.compatible = "ti,ina236",  
> 
> This is not documented. Please add/extend a binding for it.
Good point. I missed that.

As this has gone upstream now, follow up patch please.

Jonathan

> 
> Rob

