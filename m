Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795298824;
	b=3JZcozrRYJC2eDvTHvnFhh4qYgFy13j3377cyS02jfMAMPfZF716koqlHFpEct770sZT
	 cZriCUUgIWAQKFoMddYYcxGJu//jlWQ8aMjcVf48L7l0SbttRR+9SqN4hz/+EWc9qGnWJ
	 asFdifoQfC2/zcrPM4QrhfUfFFHVZDEcT1ud1yulosWPdc7DT5LaYIx09A2QSQanxda3i
	 NwOiTYjHXrMJNZpoAFRK0fEQf4q6YsXnWPF6JDS1A02QB9kEagwUC0vZbd857jfKkOtmR
	 Y/lkovoIpIUPTx+fYaBtED4E/J3hij0W3VqrgMIwzvZ4PRX5vQVG5dV07UC0hExDVfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795298824;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z0TjucsylrZUI7/YSISNCZKlSDovauWpsElrtKiAmTE=;
	b=TPxQIpNzI6oErybcdlGUpnAcN6jVdzSJ01EvC1Qmb+7WtrOGYPk3kme99TuGjxnJfNMJ
	 mbkOluaZsm9aCaMsWDQxp/vQbLSBKqcy/VBJTiBWsrrHZOXeHJYrI4Ct5CRvMkN7mVTyK
	 Fsd77OD/RSQkmZEtFLbZo1ZfNr2eM9+YyVpGr2/hyU2dDG9pcvtcy650i+D44E+rYkBQ4
	 d//uvO7fs1H+BXTcM648h7tyUcCQUKyau96HSPg8Lf9E6oWxqiRRvOKWA6m57Jfs11cmT
	 m1FsWXrTHj2vq9mb5vZMKIHUgoM33fBCqKnTxdsRP6LOe+K7LVIQjjzfwffqk80Y3/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+0KxTOJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479CD606A320;
	Sat, 21 Nov 2026 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+0KxTOJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B33F1F000C4;
	Sat, 21 Nov 2026 22:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795298823;
	bh=Z0TjucsylrZUI7/YSISNCZKlSDovauWpsElrtKiAmTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V+0KxTOJBIPSRLngxWDyVqvD55uwC1KzxtAjUrL4GQPxjTndXDD/HuznVowVQPZLE
	 4twZK5df5IXWtq+MQ0zcAM7A8v+gJvEzxpoHkTT5mZ4Am78HRMsPKW18Ya7Uj1KfOb
	 b7ZG8jKtH3h2aYlZ68AOFXySv6nD79E7pmAiFGlsvVaLhGtv16PryD1/o4iZ092YSv
	 cTOCir5YVUJ+y38psvNxAKg1RvTA/jByJQU44OJIWP+5USZ6+pYhgFCGTHjFpcxvjU
	 UiNwWv43Z/p6763T0BaAPKUiDDkNOcTaZ9z5byWCysrKHpBCBtvG0TiAevPwbJU5sI
	 1DdLzojzf1nrQ==
Date: Sat, 21 Nov 2026 22:06:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Siqi Chen <chensiqi@uniontech.com>, jagathjog1996@gmail.com,
 crofts@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bmi323: check i2c_transfer() return value
Message-ID: <20261121220657.3e886340@jic23-hlaptop>
In-Reply-To: <awAVDTwKYxT7v8mL@ashevche-desk.local>
References: <20261120022143.4065982-1-chensiqi@uniontech.com>
	<awAVDTwKYxT7v8mL@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 11:38:21 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 20, 2026 at 10:21:43AM +0800, Siqi Chen wrote:
> > i2c_transfer() returns the number of messages transferred or a negative
> > error code. The BMI323 I2C read path only checks for negative values and
> > maps all errors to -EIO.
> > 
> > If only the register-address message is transferred, the function copies
> > data from the receive buffer and reports success even though the read
> > message was not completed.
> > 
> > Require both messages to be transferred, preserve negative error codes,
> > and return -EIO for a short transfer.  
> 
> > OpenCode was used to identify the issue and draft the code and changelog.  
> 
> This line should be in the comment block, behind the '---' line.
> No need to resend (just remember for the future submissions).
This time I took this and dropped that bit whilst doing so.

Applied to the testing branch of iio.git as not high urgency.
In practice short reads only occur in very very rare circumstances.

Thanks

Jonathan



> 
> > Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
> > Signed-off-by: Siqi Chen <chensiqi@uniontech.com>
> > ---
> > Changes in v2:
> > - Split the transfer error and short-transfer checks for readability.
> > - Move testing information below the separator.
> > 
> > Compile-tested with CONFIG_BMI323_I2C=m using:
> > 
> >   make O=/tmp/opencode/linux-build-bmi323 W=1 \
> >        drivers/iio/imu/bmi323/bmi323_i2c.o
> > 
> > No hardware or I2C fault-injection testing was performed.  
> 
> Code wise LGTM.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

