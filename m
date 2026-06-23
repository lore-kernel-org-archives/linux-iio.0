Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C931F151C;
	Tue, 23 Jun 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242192; cv=none; b=qmCOB6TBH8wM1gdWLIof9L0vIdMFxgnvlbNiugEZ+/9thkNqXRVYlA6pnp9QpBCL/4f4OxMosUMGk6nikHVrt8So6pv7vh5g9h4I9su58G2scdb+aQRWW6G/MSldnlSJ+tiOaH3JGGtnGd2QcLeKSLhEroHCTneq6G9QF8CZ1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242192; c=relaxed/simple;
	bh=xgXBjmmVu7U9y3F5IEB2Zlr8WsiAMYvU903JQzEbprk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y77hnnIjvyBp6O5Cj76jwJ33LJupYf8NUFTAc43dFF+wTz+PmydrMrYe3IqkpPMRVJ8/x5zpRmAy25LdPYw3NzveWJHBUNDZEqGxZjVX9vyUBhBsMamwi5qVvFqERgW4hnLSpKpB5w7KVBWZAsbMbfxAuUYDMuxSRebGBl69Km0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7ZgclmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7ZgclmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B165D1F000E9;
	Tue, 23 Jun 2026 19:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242191;
	bh=MR4iKhhUgO08LKdfXft9II1LaZb4C3k/aKImea5aa60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m7ZgclmEp2vE3Wnjf/CG704tN8RqF+jH0zih1NUtjxlT6C1Q6yhpA86RavWvh7SvA
	 9N5Cb6TRDs4AZvCeQjACZwHADolcGpwFrC+mPKwaontVXsK++C0Sr+HasCb6/9un57
	 Zj870eQTZabmEipeOBMdJZt8m83/fWPH//wnVXbjh5SCnukL6VsNuAjB/EzNVwLvTW
	 0Eck332Um52RQU5nFvmPk+8KQUB4JVSRvVJgr84mdz8N4tZOEYPxcK9WjIVIebmyam
	 ZenWeeBVnpm7j1UiJkUUm1C6+YWu99R8EIDRvCK+JMCaCZQh+bipzMXhMs94qqSgHj
	 idsV+fDtOhcow==
Date: Tue, 23 Jun 2026 20:16:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: magnetometer: add driver for QST QMC5883L
 Sensor
Message-ID: <20260623201625.3b92f93a@jic23-huawei>
In-Reply-To: <20260619104524.10172-4-siratul.islam@linux.dev>
References: <20260619104524.10172-1-siratul.islam@linux.dev>
	<20260619104524.10172-4-siratul.islam@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 16:45:06 +0600
Siratul Islam <siratul.islam@linux.dev> wrote:

> Add driver for the QST QMC5883L 3-Axis Magnetic Sensor
> connected via i2c.
> 
> Signed-off-by: Siratul Islam <siratul.islam@linux.dev>

I'm going to apply this now but given rc1 is still some way off plenty
of time for more feedback or tags!

Applied to the testing branch of iio.git with a tiny tweak.

Thanks,

Jonathan

> diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
> new file mode 100644
> index 000000000000..b7fff3b63ca4
> --- /dev/null
> +++ b/drivers/iio/magnetometer/qmc5883l.c
> @@ -0,0 +1,517 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * Support for QST QMC5883L 3-Axis Magnetic Sensor on I2C bus.
> + *
> + * Copyright (C) 2026 Siratul Islam <siratul.islam@linux.dev>
> + *
> + * Datasheet available at
> + * <https://www.qstcorp.com/upload/pdf/202512/13-52-04%20QMC5883L%20Datasheet%20Rev.%20B.pdf>
> + *
My pet trivial complaint.  Blank line adds nothing useful. I'll remove it whilst applying ;)
> + */
