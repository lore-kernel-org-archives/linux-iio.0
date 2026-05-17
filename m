Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E297435B650;
	Sun, 17 May 2026 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018273; cv=none; b=MnbmP8d0sLDER191HiylL5wj4NkdJmqv+O942PPQh2Jw+TJN5pb3MIShsCzvTLNSl9Rhq304Ua7kEala7vGaLTTCjHiifJ9jwxPv01LvnSU0EMhfgDtSWE9FW2xUN/yLjYeFNF9FTn8Y5NLfxqBosFRttNgxLFa8gO/PUlf+xU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018273; c=relaxed/simple;
	bh=YgGaQcw3JYZr0y/z5J8a70ItGVZWnTr/ZVptLBQuMuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZaCwwgTwhdFNI7bVNETFzlRsUTuHJU94/BGFlKhHmTfP1deo09iwBLEEJD1nIG2xYRvfQtgKF/8jXkSIB1WmM+5yW686P8KXfn3bmWfRR0ucy4vl5/68Lj2JWUIlFumf7ENYck1e75iQkCGiMqIX0eJMdWdyKhCcyhJWmBiY5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdPekc4G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdPekc4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF7DC2BCB0;
	Sun, 17 May 2026 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779018272;
	bh=YgGaQcw3JYZr0y/z5J8a70ItGVZWnTr/ZVptLBQuMuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZdPekc4G6ZHG9xmiZ9r3U/ZZtuOc6Z1pbCF5VNHcI546BJcx8gjj7iVfGJPTTjv3z
	 /kZpneUSywdpKMgiV0ZSyfJKuOW9sx/t9vZneoeTq9yaBIM7KeceiO72A6wUksxsFg
	 arj28Y5E3PmIwDELbcg2fWIIKwzC4loVBALfDnzJOQ3d3lDkFNPpgMsNc9u83cKcfC
	 C6M3RdU+q485Ug8oMVaD7EnWF1nhWKMlW314U2BFrCVaZUS2X1r4C/Z4lnPp0cwcXA
	 1NZeJ7cwYzcIrLVpvlR0+A0bqVW8+HcWiaNnxVCJwJO5YdH0PWwpd3C15xAUyprKXM
	 0rbcsopYkW5iA==
Date: Sun, 17 May 2026 12:44:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: salah.triki@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: humidity: ens210: Extend I2C functionality
 check
Message-ID: <20260517124424.2cb1961f@jic23-huawei>
In-Reply-To: <20260517073823.1280-1-sozdayvek@gmail.com>
References: <20260516173148.3209f7fe@jic23-huawei>
	<20260517073823.1280-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 12:38:22 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> On Fri, May 16, 2026, Jonathan Cameron wrote:
> > Sashiko pointed this out... Take a look at definition of I2C_FUNC_SMBUS_BYTE_DATA
> > and consider if the line above makes sense.  Check for other instances of
> > this.  
> 
> grep across the driver shows what actually gets called:
> 
>   i2c_smbus_read_byte_data       -> I2C_FUNC_SMBUS_READ_BYTE_DATA
>   i2c_smbus_write_byte_data      -> I2C_FUNC_SMBUS_WRITE_BYTE_DATA
>   i2c_smbus_read_word_data       -> I2C_FUNC_SMBUS_READ_WORD_DATA
>   i2c_smbus_read_i2c_block_data  -> I2C_FUNC_SMBUS_READ_I2C_BLOCK
> 
> i2c_smbus_write_byte() (without _data) is not called anywhere in the
> driver, so the WRITE_BYTE flag in the current mask is dead. WORD_DATA
> asks for both read and write word data, but only the read side is used.
> 
> Minimal correct mask:
> 
> 	I2C_FUNC_SMBUS_BYTE_DATA |        /* read + write byte data */
> 	I2C_FUNC_SMBUS_READ_WORD_DATA |
> 	I2C_FUNC_SMBUS_READ_I2C_BLOCK
Yes.
> 
> Stepan
> 

