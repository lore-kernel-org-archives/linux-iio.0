Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A97187346;
	Mon, 27 Jul 2026 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119229; cv=none; b=VpQkT8PQkrc4TQ6UvrRHEOXvhA6e+HeXj6vDb1Y9OfOIOZnIi0pLcwUjnAih3xWx38tbgpDoCPkDyA0tUqEAfY0Xfh1iqbKeRubliKqcTkmTcDjOzQQm8waq3TA32kKhaO0Qqt1vPXFh6Svfw4snI2/Z5XUEza/s8l+c11vWdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119229; c=relaxed/simple;
	bh=Lgi7amTDfKhfrnC2hsMmYADrT5AmfZKdxIMCqAwfQ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogdOXGuOT6UNL8bsugESN9/D2MDm3WpGFX/npL7+su/w1OPCBqQY50cIjr6bEaJKnxuDmvq8IrVzc/SpjV6FaR9BPJIiyTWm0t1Td7Iib67wY5qj02EkuU2CuVT6zPMJLlHCrwL2y07RUuBvo7u4bxDb/3Ui/a5kE5/R9BlcZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr/FrMYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr/FrMYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D851F00A3A;
	Mon, 27 Jul 2026 02:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785119228;
	bh=THkU+FvYXuDF/gOh3xpmtNnA75bi5cnc57IzJ2h3Yc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kr/FrMYGsl/qT4p7QgcQz3RFS6DxyXesMzXNPfFFi0EolB10w0jM3Pz9/UAUClF0I
	 PygSZ+eiHRh31eN16S6pBKiB0ua+m84fLI1vRmqnn2HbQHxF2vZG3u9Tmf0mLDMGBI
	 qd+lSEfNqJvNX2F2fqnH0hCNssa042tdo8rwW6ysT9nnKn59v5qgCF7ukFBXaAUh24
	 3QjgW6uiLLPUIZjCGDkQISC/azRuyM3OIHIyNeUiejxW95eEDrwieOfXT91LBL5xtv
	 37SY+9bc4LzWXpmD3mMd5ziDMR8yyuVEoQrFewOoBpdVcJ7YPFk6T5Cvi2ZfvO1PFP
	 YuSlqlXJVS6nw==
Date: Mon, 27 Jul 2026 03:27:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: ktsai@capellamicro.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, daniel.baluta@intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 me@brighamcampbell.com, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4 1/2] iio: light: cm3323: fix reg_conf not being
 initialized correctly
Message-ID: <20260727032702.12d1f7bb@jic23-huawei>
In-Reply-To: <39df42eb-433f-4cc5-b76a-8a7beeb3704b@gmail.com>
References: <20260407151702.15208-1-aldocontelk@gmail.com>
	<20260407151702.15208-2-aldocontelk@gmail.com>
	<20260420185333.3bab224d@jic23-huawei>
	<39df42eb-433f-4cc5-b76a-8a7beeb3704b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 13:44:19 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> On 20/04/26 19:53, Jonathan Cameron wrote:
> > On Tue,  7 Apr 2026 17:17:01 +0200
> > Aldo Conte <aldocontelk@gmail.com> wrote:
> >   
> >> The code stores the return value of i2c_smbus_write_word_data()
> >> in data->reg_conf; however, this value represents the result
> >> of the write operation and not the value actually written to
> >> the configuration register. This meant that the contents of
> >> data->reg_conf did not truly reflect the contents
> >> of the hardware register.
> >>
> >> Instead, save the value of the register before the write
> >> and use this value in the I2C write.
> >>
> >> The bug was found by code inspection: i2c_smbus_write_word_data()
> >> returns 0 on success, not the value written to the register.
> >>
> >> Tested using i2c-stub on a Raspberry Pi 3B running a custom 6.19.10
> >> kernel. Before loading the driver, the configuration register 0x00
> >> CM3323_CMD_CONF was populated with 0x0030 using
> >> `i2cset -y 11 0x10 0x00 0x0030 w`, encoding an integration time of 320ms
> >> in bits[6:4].
> >>
> >> Due to incorrect initialization of data->reg_conf in
> >> cm3323_init(), the print of integration_time returns 0.040000
> >> instead of the expected 0.320000. This happens because the read of the
> >> integration_time depends on cm3323_get_it_bits() that is based on the
> >> value of data->reg_conf, which is erroneously set to 0.
> >>
> >> With this fix applied, data->reg_conf correctly saves 0x0030 after init
> >> and the successive integration_time reports 0.320000 as expected.
> >>
> >> Fixes: 8b0544263761 ("iio: light: Add support for Capella CM3323 color sensor")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>  
> > Applied this patch, but patch 2 will need to wait for this to make its way
> > into upstream - probably middle of the next cycle before that is in place.
> > 
> > thanks,
> > 
> > Jonathan
> >   
> 
> Hi Jonathan,
> 
> The fix this depended on (commit 1f4f0bcc5255 "iio: light: cm3323: fix
> reg_conf not being initialized correctly") has since landed in mainline.
> 
> Is there anything still needed on my side for patch 2 (iio: light: cm3323: use 
> dev_err_probe() in probe path) to proceed?
Good thing you checked - I'd marked it wrong in patchwork and so had lost
track of it :(

Fixed that now and applied to the testing branch of iio.git

Thanks

Jonathan



> 
> Thanks,
> Aldo
> 

