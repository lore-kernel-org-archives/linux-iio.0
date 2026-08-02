Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E6262808;
	Sun,  2 Aug 2026 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689818; cv=none; b=Gijw2SUe9nSP/d80d99n6Zthzi+D2YyPnWOux2XcosGfA3/+YTGZ/ka6Ul9fWRBXmEbvGsWLUhadRlUpWZvKhQxHbbY4YRfpuP0amjTeKK/4yJXeVcoKhfvJnVFXIkjLguX1erY+uEb73WBgp42Npc+UCXxqU5+NYwblPlme5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689818; c=relaxed/simple;
	bh=UYj/8/sPkA/+jqwyNKq8M0eFVii1VImucTpFNyJ1i9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRLOIRNUe0McEV0C7A9Nt2yRJ8ygTCV3FH5nPWtanxARiWsAro4Xi7kszb12435y92IZ2EX+C9dBCMtFSpQ1/aeC9zX+vHiGfaBUhw6C56DgOi1eSDNuKTm6D+R/ZK+IhwgbL6RbGnjxdz4Y4qYIfg3U7T+1U3ybkJXtL548x5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNhcsCGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNhcsCGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CAB1F000E9;
	Sun,  2 Aug 2026 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785689816;
	bh=gIw6SXWx9dw9s6rvvkTvzjfybSlZKH/e6BuOvWYZPWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bNhcsCGjET6bdq4uLc+7xe+tLZ78aIJv0akAvm/tpivr/NEeQ2dFs3hXIsvD7QDll
	 lwz8kxcuqlbWIoWNSobCXkJ7ZOEBdnhqnGWexH1c4I8SnHQ0CeniSZj3cpboFvM9d7
	 baw7zYn+MR5uxSpl04/GlX4sr/0x5Jl1gL8Cmb3QB4vpvD2ZoTlwzLC9xoLfDA2Nsq
	 Gqcizr+seesgnqTM5qMHB6yJdc4GHw1QD1Rac3T196XCX3mryMxnk8s0ZFpthHnn8Q
	 kaRJYiRwt3d8+1PrJeFQFqoWo1HgWGHi2S7GtEek79d8YtPRrKssAR4aLrSztra4e8
	 TROj8wbripLfg==
Date: Sun, 2 Aug 2026 17:56:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 u.kleine-koenig@baylibre.com, dakr@kernel.org, bhelgaas@google.com,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: htu21: Fix SYMBOLIC_PERMS chekcpatch
 warning
Message-ID: <20260802175650.54895dff@jic23-huawei>
In-Reply-To: <20260802012329.9877-1-adinata.softwareengineer@gmail.com>
References: <20260802012329.9877-1-adinata.softwareengineer@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 09:23:26 +0800
Adi Nata <adinata.softwareengineer@gmail.com> wrote:

> Checkpatch warning:
> 
> WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +static IIO_DEVICE_ATTR(battery_low, S_IRUGO,
> 
> WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
> +static IIO_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR,

Would be nice to have some information on why they are not
preferred as part of the patch description.

> 
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> ---
>  drivers/iio/humidity/htu21.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
> index a9dbf08b4f1a..fe7192d142ec 100644
> --- a/drivers/iio/humidity/htu21.c
> +++ b/drivers/iio/humidity/htu21.c
> @@ -154,9 +154,9 @@ static ssize_t htu21_write_heater(struct device *dev,
>  }
>  
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(htu21_show_samp_freq);
> -static IIO_DEVICE_ATTR(battery_low, S_IRUGO,
> +static IIO_DEVICE_ATTR(battery_low, 0444,
>  		       htu21_show_battery_low, NULL, 0);

Now fits on one line.



> -static IIO_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(heater_enable, 0644,
>  		       htu21_show_heater, htu21_write_heater, 0);
I don't mind having this one on a single line as well even though it is
a bit over the 80 chars soft limit at around 84 chars.

static IIO_DEVICE_ATTR(heater_enable, 0644, htu21_show_heater, htu21_write_heater, 0);

>  
>  static struct attribute *htu21_attributes[] = {


