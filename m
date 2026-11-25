Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616584;
	b=BBeDeJ8NUrIN/cj0wvjHa2aVxmYwqs7NVVOcG8vreWkOa4apfzRhCgES9ogM7HFB2qxO
	 Lm5/txXJv9kbN9q7p3bBX8biKyyAED/QAc4F10ptigzWT2LvPoxbjGTIYFJ7cpvqrtp9X
	 Y6dbddqeHsSZ2s88Betee9ahbbpiV0LByP5qiQRLChSbtINiLgHi+Z7+kprYQ7sm5szoA
	 3TsDEFXBLnBXImxrbagkC/x8VER7BTz5uSsNcnfu4bBCsZD4Mr/MUF5dV0PhQSebsHe+h
	 GQIzuEYrE00hk66rFOPIk2WWwOa4TQB6+Au851tAQRGZIyNrw/s1zBAqiWzI/NJkpWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616584;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xe2pt9boqTUR8UZdvw4mJFYWCAPeJ6m0605Dc7jLB2g=;
	b=M0DK0LbF3hCHJEOMpkc4JQmnOJeADXrGucjrp71YrHm/F6f2YXMx10V41jaABG55kyCZ
	 HjDWjCXRRyNGt+wsZQEtJDX2qlu1NfMJLeswWM52M6aaB/m2dmbpwizHraEgQdWRvxkpJ
	 jAUyTVL4/39EcSmtVweebOm70VVHmBwozqyUB4vEoXpwSgSPDw8eHwENGenEtp0suzB8P
	 YMqDhh/ndS51O/u7wrKrh/bWNPAN8v2yv+GkiRjuvyU9lf7RgIZQyGFyVr7NDC5GdQR/h
	 c69dTuDwK7AMJqlyhdzT58QcLORX8jkyRLgRmrUbx0EZYZo9Y49RzZYH6TUWIOjiW0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cplLkniH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33645606A31E;
	Wed, 25 Nov 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cplLkniH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35871F000C0;
	Wed, 25 Nov 2026 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616583;
	bh=Xe2pt9boqTUR8UZdvw4mJFYWCAPeJ6m0605Dc7jLB2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cplLkniHCpZxJXnvEAgB1HM5BlMm2BQg9E00lhEPqzWbim3Zj3BAPzg4UNFXfik16
	 Q/8H/MZZu9028P5oUfuENggY6mFtebYNN1Mx0RJiACA34tJvDqaNjjnLFQ4Qu5pkZM
	 NpTr2zP5FX1TChapPFyLxq2K06KxcE9zk6ScMbxJ9KD4CFQE0k2GJdh34oA+BY8D3Y
	 MTShpZ71DGGW6/URMBnT1wiwxdjUn2q0zv2DyCTwFGcA2CnIZRYuE4zBUZmG7YpX8X
	 fPKICUUdgUxCkN/SirhwiJGvQNtBCerKFZW/ZYsn4Y27UbDlNqKrPff9fbKARrdsWT
	 Fp1uIJsMQldyA==
Message-ID: <6d517c95-82e1-4713-bc1f-9922a975e26d@kernel.org>
Date: Wed, 25 Nov 2026 15:22:59 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] iio: core: Split debugfs routines
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rupesh Majhi <zoone.rupert@gmail.com>
References: <20261125140251.384361-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261125140251.384361-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25-Nov-26 14:59, Andy Shevchenko wrote:
> Split debugfs routines into a separate file for easier maintenance.
> No functional changes intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> ---
> 
> v2: fixed compilation errors (LKP, Joshua)
> 
> Cc: Rupesh Majhi <zoone.rupert@gmail.com>
> Rupesh, feel free to include this patch into your series as the first one.
> 
> Fun fact: This patch was written with zero AI assistance.
> 
>  drivers/iio/Makefile               |   1 +
>  drivers/iio/iio_core.h             |  14 +++
>  drivers/iio/industrialio-core.c    | 152 +-------------------------
>  drivers/iio/industrialio-debugfs.c | 165 +++++++++++++++++++++++++++++
>  4 files changed, 182 insertions(+), 150 deletions(-)
>  create mode 100644 drivers/iio/industrialio-debugfs.c
> 
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 8a897b6729d2..5fd81b20da22 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -8,6 +8,7 @@ industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>  industrialio-$(CONFIG_ACPI) += industrialio-acpi.o
> +industrialio-$(CONFIG_DEBUG_FS) += industrialio-debugfs.o
>  
>  obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
>  obj-$(CONFIG_IIO_GTS_HELPER) += industrialio-gts-helper.o
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 59fa1bd9924b..985ac82a37f9 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -16,6 +16,20 @@ struct iio_buffer;
>  struct iio_chan_spec;
>  struct iio_dev;
>  
> +#if defined(CONFIG_DEBUG_FS)
> +void iio_debugfs_create(void);
> +void iio_debugfs_remove(void);
> +
> +void iio_device_unregister_debugfs(struct iio_dev *indio_dev);
> +void iio_device_register_debugfs(struct iio_dev *indio_dev);
> +#else
> +static inline void iio_debugfs_create(void) {}
> +static inline void iio_debugfs_remove(void) {}
> +
> +static void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
> +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}
I checked Sashiko and it points out that building with debugfs disabled
causes compiler warnings:

In file included from drivers/iio/industrialio-event.c:22:
drivers/iio/iio_core.h:30:13: warning: ‘iio_device_unregister_debugfs’ defined but not used [-Wunused-function]
   30 | static void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/iio_core.h:29:13: warning: ‘iio_device_register_debugfs’ defined but not used [-Wunused-function]
   29 | static void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC      io_uring/fs.o
  CC      io_uring/splice.o
  CC      io_uring/sync.o
  CC      kernel/nsproxy.o
In file included from drivers/iio/inkern.c:18:
drivers/iio/iio_core.h:30:13: warning: ‘iio_device_unregister_debugfs’ defined but not used [-Wunused-function]
   30 | static void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/iio_core.h:29:13: warning: ‘iio_device_register_debugfs’ defined but not used [-Wunused-function]
   29 | static void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Better to mark the functions static inline.

After adding inline,

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
