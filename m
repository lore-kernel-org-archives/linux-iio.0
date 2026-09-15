Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2AA47207C
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472404; cv=none; b=GU2ffV240ERgr7jOoV0GPg/X0//PigoUjDNJdhGmvBlXSbtXpXO0Gk8ik6Au22B+KEvW532+UaF9RiQD9R8pvlVSyUqKcOFFCMiQXBe8ywhxMhkbrp+a79f7w0GuozltpsWM14+NQwY0gpW+BrP+fNxMbwzUrIW7T/rUfgn/Fr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472404; c=relaxed/simple;
	bh=1oTYk7P3ixkGAIPYYhAsSjZavggk1RqaIlfV936Mmqc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:In-Reply-To:Subject:
	 From:To:References; b=I60V/xNKE2Fu2vlzO5KsVt00IVVl6ZE/F31Ye8IterJTacXE5OAGe3TMeHiqUyR4RqLn1N8d8aiIYhFfpHMDrUz3hmJKijilIViRFkIb4KYMtYaX+IpJ5/cR/EYkxFT8B0nCz/H3bY6HVAezF5WQXBGARvQUTls/jxxZMP8qm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=Slcpzh0r; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=BS92hTCF; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="Slcpzh0r";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="BS92hTCF"
DKIM-Signature: a=rsa-sha256; b=Slcpzh0rQhfiodaqHqflT4n2W/mic2PVBqo3OMM6mdFOJZclGJiLt+Eohal5Ftio8B1WWJAg93LTehkB1dBvQCTwRkOPzCnNMn6/HI6UOYdbwulos3+g+6v08k7JlEXZGo0m2N85J0wIqD6kWXLtB7eXSptid+ppTMf1IA5uBY/X5OyMOMPS8B1bpvCb0Bpg0q1CwXvlbOPg8OBIPX1cnVSCIRjKdoZt2TEoAYG5fTg63kt/qmD829twk8ezP0BZisY1yLZfIW8USrnc4X0Kai78LMTLXWqI6jRIjW2pqSS9p7o4irQhxGalLGS1R4qp1hG94o5NSVaztUQ34urNww==; s=purelymail1; d=maxwelld.cc; v=1; bh=1oTYk7P3ixkGAIPYYhAsSjZavggk1RqaIlfV936Mmqc=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=BS92hTCFr1BefpBHyV7HJlX1a/Ng/RRIidN9egCfJQZ8wajPLl523TD4AM+rLtkG2kjUHkXKWNjA9ECnsb8hYRr0XX2KQViikFuiTumuduvHzAnRWsgUeK8/kwCEgXwigjt9e1z0QewN2pEOzn5lifcYgodB3bApsOOh77igdO50GwyTpUgbM/gTPvL9hHShyzo7HfnAfDzQCTy/OyYZsoVhJ86xECDgilMtMMXbMD8+0+ovO/zh/l/Qc9qcsumSTcIjco/mNYIOBjZH7uJ/YFH/5gN85wpbYuO0h/LxSpxArOhxFyiatjpnPyU5p8qo/WSB7U0GxTjVhFlLGUyBaA==; s=purelymail1; d=purelymail.com; v=1; bh=1oTYk7P3ixkGAIPYYhAsSjZavggk1RqaIlfV936Mmqc=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2093946323;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 15 Sep 2026 11:39:35 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 06:39:34 -0500
Message-Id: <DLFV0K85626F.2MUXL6JKFNF5H@maxwelld.cc>
Cc: <dlechner@baylibre.com>, <andy@kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <joshua.crofts1@gmail.com>
In-Reply-To: <20260915075939.18180-3-abdelnasserhussein11@gmail.com>
Subject: Re: [PATCH v7 2/3] staging: iio: adc: ad7816: Serialize SPI
 operations
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Abdelnasser Hussein" <abdelnasserhussein11@gmail.com>,
 <jic23@kernel.org>, <gregkh@linuxfoundation.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
 <20260915075939.18180-3-abdelnasserhussein11@gmail.com>

On Tue Sep 15, 2026 at 2:59 AM CDT
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> The ad7816_spi_read() and ad7816_spi_write() functions perform a
> sequence of GPIO state changes followed by an SPI transfer. If multiple
> operations occur simultaneously, the GPIO state could be changed by one
> thread while another is in the middle of a transfer, leading to a race
> condition.
>
> Introduce a mutex to serialize the operations, ensuring that the GPIO
> toggling and the SPI transfer are treated as a single atomic operation.
> The mutex is placed right after the pointers in the device state
> structure to avoid padding holes.
>
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
...
> @@ -47,6 +49,7 @@ struct ad7816_chip_info {
>  	struct gpio_desc *rdwr_pin;
>  	struct gpio_desc *convert_pin;
>  	struct gpio_desc *busy_pin;
> +	struct mutex lock; /* protect device state during SPI transfers */

I'm a little on the fence about the comment but if it satisfies
checkpatch then thats one less patch later.

>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;

Good find!

Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>

Thanks,
Max
