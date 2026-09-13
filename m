Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D538B125;
	Sun, 13 Sep 2026 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341321; cv=none; b=qAY0wSOYSu7TqO8Wu9/gvvLa/665gMO2m09w/WQ10UY1oTjUK2Igbjjmg5QhfeeVOwYq8I+CfuWxu6i+twUacnmJEFIdrz7Yru7FjaIbcR3FL4LuQxChI8m+1sCYGpfxbTWNF5Cvddmd/eEXAROJ7R7gq3f8O47K37wLsT+HOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341321; c=relaxed/simple;
	bh=rKOn5rgHI/o9+0DA/GV4TbuOaB3SttLfhI4tfqKF5mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMjiFTeO0yEIqADv0VxVUz/FwuKuaw8OYic0dgx2svvuI32DLQYF57eLqEM6mJmndT9KL7uBuRAqrDzwoi+mE9QUpa8OUjgqVT9ExQ4l7MezkIhfyRJUSOwFBGystvkXantI35pqMqOMJSeihAf+3y5QR/QWrAXYhoI1asGVlJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVeVkMYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVeVkMYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DE31F000FF;
	Sun, 13 Sep 2026 23:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789341319;
	bh=AEG6A2YmRNnHTq6KZzgnKQ0Iu7WheUbYJLS4gaz2nK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MVeVkMYBwSFZ3Qy/NsXR6DV2Xusfk3K4fQVZkGyVCDLy8FtH2lluTfv8fdvCaD3Ne
	 J9LPxcQQVFeiQtgaX5Se3eEeBlZU5vorQJ+c/RFJTRdE82Kc3bLPRiYmUs01CIEERu
	 5aPLjAxN2z75TPy14fWC+Q2IGBnc5q1jJL7DZ2Tfk1s5473HddCjPubeoIgc30ejjl
	 XwqWm3futV4/1iVYt4xIxfIA7A3Q+nqydapia/aEkoAeUv+1s3vAd3vXwdc18wxlCG
	 gvTRFXn/p1ITxFVkhi03+6fi6J/Mc4T7VFOY8C0txhJR7P/0rLkVEZPtAn+E+yDMJd
	 i+SXRa/D/0hiA==
Date: Mon, 14 Sep 2026 00:15:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer
 <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, Christoph
 Muellner <christoph.muellner@theobroma-systems.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/9] iio: accel: mma8452: Add comment block for
 struct mma8452_data
Message-ID: <20260914001514.3a33ce55@jic23-hlaptop>
In-Reply-To: <20260907-mma8452-open-drain-v8-6-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-6-c17407e22118@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 16:51:01 +0200
Esben Haabendal <esben@geanix.com> wrote:

> The struct mma8452_data is central for this driver, and it makes sense to
> have a description of the fields in it to make it easier to work with the
> driver.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/accel/mma8452.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index c6af68d2a297..2c1b97b77bc1 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -104,6 +104,22 @@
>  
>  #define MMA8452_AUTO_SUSPEND_DELAY_MS		2000
>  
> +/**
> + * struct mma8452_data - IIO device private data structure
> + * @client:			the I2C client object
> + * @lock:			mutex for synchronziation of register
> + *				read-modify-write and holding chip in STANDBY
> + *				mode while writing to registers
> + * @orientation:		mounting matrix, flipped axis etc
> + * @chip_info:			chip specific data
> + * @vdd_reg:			reference to VDD regulator
> + * @vddio_reg:			reference to VDDIO regulator

These don't exist any more.  Sanjay did a conversion to bulk regulators
that I picked up a few weeks back. Please rebase for v9 on top
of the togreg branch of iio.git.  Seems that sashiko figured out enough
to base this on a more recent tree than you have.


> + * @buffer:			triggered buffer
> + * @sleep_val:			time in ms to sleep while waiting for drdy
> + * @ctrl_reg1:			CTRL_REG1 register shadow value
> + * @data_cfg:			DATA_CFG register shadow value
> + * @open_drain:			true for irq pin in open-drain mode
> + */
>  struct mma8452_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> 

