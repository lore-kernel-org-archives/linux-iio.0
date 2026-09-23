Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2D43B6C9;
	Wed, 23 Sep 2026 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149967; cv=none; b=Vr51H17wwxbXx5Sl7RHLYhxQ460TXvDxr3cG3sQAqRhsksf4Aqd4UkJvHJqrgJMjWwlYhR3uDmDeDIBt4lR11H/560glzpl8zQX/Vl/picXgziBhd4E/PuvlhAkD+IBvVRl06PQGC2L+XrQMArxtVxnrlq0fLq8PqeX6qRN3B1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149967; c=relaxed/simple;
	bh=sAwvvJEsRCy2dlXuAhe0j3AjpfxinUPWn0ObDQIkyo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9vNjBNvjMO3gV1700Lnj+rnNidYD4gS/BA3/hSoNPvaN8kAAjjWVHlReXx4/Y/CwfVzGgt54Sks8QuUkANqIs+8C0OSdT4YDZb9Ad3VVxh9ZyijX/9ssUttg8+UaLVEN3Ob6CQiKyNXOwyniew1iKT5W+8/OfMpEgbh5Crn1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVAOzvvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVAOzvvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2C41F000FF;
	Wed, 23 Sep 2026 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790149966;
	bh=WyRyxluqkbwZerdj5nXV2WSJfQ+l1Y/79i2MJeNR+oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lVAOzvvGLhKLRZwdI/FL1zw0i0zlIoQ0V2S4VlCilNo8sq+aPfa/bQiJP4Wi50Q0y
	 dPbbpEgig7BDBLO4FxzX3Ja2pXYZJCXUfVm/fgy+i+pOi3pNJlj1A3nopnucX139fe
	 88rgvSL7eVu9jlTGOEGcylCnb1b0jndesfq84Oyxh8DEezVLeakVm0+vCCSvbG88Mz
	 Qerg/nbQqXDZrERNF9vIWCsiXLk4HG7kLloDm16Q73YcscCAXW75vaVEnyKvh9bYYA
	 maqaAlCnViHZLlfI8+Y3Cpc077tpSUTBjLJ1fQSwXXNV5LaL6wJwiGMbc2bdP9zDNE
	 SS9SJV3e0Rhsg==
Date: Wed, 23 Sep 2026 00:52:46 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	codemender-patching+linux@google.com
Subject: Re: [PATCH] iio: st_sensors: add __counted_by_ptr to struct
 st_sensor_settings
Message-ID: <202609230033.E3A658F@keescook>
References: <20260922112111.1970872-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922112111.1970872-1-morbo@google.com>

On Tue, Sep 22, 2026 at 11:21:11AM +0000, Bill Wendling wrote:
> Annotate the "ch" pointer member of "struct st_sensor_settings" with the
> "__counted_by_ptr" attribute. The elements of "ch" are counted by the
> "num_ch" member in the same struct.
> 
> All instances of "struct st_sensor_settings" are defined as "static
> const" arrays across the ST sensor core drivers. For pressure sensors,
> "num_ch" is explicitly initialized with the size of the respective
> channel array using "ARRAY_SIZE(...)" during static definition.

I wanted to understand this so, in drivers/iio/accel/st_accel_core.c:

static const struct st_sensor_settings st_accel_sensors_settings[] = {
...
                .ch = (struct iio_chan_spec *)st_accel_12bit_channels,
...
}

static const struct iio_chan_spec st_accel_12bit_channels[] = {
        ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
                        BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
                        ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 12, 16,
                        ST_ACCEL_DEFAULT_OUT_X_L_ADDR,
                        st_accel_mount_matrix_ext_info),
	...
        IIO_CHAN_SOFT_TIMESTAMP(3)
};

#define IIO_CHAN_SOFT_TIMESTAMP(_si) (struct iio_chan_spec) {           \
        .type = IIO_TIMESTAMP,                                          \
        .channel = -1,                                                  \
        .scan_index = _si,                                              \
        .scan_type = {                                                  \
                .sign = 's',                                            \
                .realbits = 64,                                         \
                .storagebits = 64,                                      \
        },                                                              \
}

So .ch is assigned an array of items which looks to end with a termination
sentinel. And .num_ch is unassigned:

$ git grep '\.ch = ' drivers/iio/accel/st_accel_core.c | wc -l
16
$ git grep '\.num_ch = ' drivers/iio/accel/st_accel_core.c | wc -l
0

> For accelerometer, gyroscope, and magnetometer sensors, "num_ch" is not
> explicitly initialized (and thus defaults to 0). This is because those
> drivers hardcode the channel count to "ST_SENSORS_NUMBER_ALL_CHANNELS"
> rather than using "num_ch" from the settings struct.

Yeah, checks out:

$ git grep '\.ch = ' | cut -d: -f1 | sort | uniq -c
     16 accel/st_accel_core.c
      4 gyro/st_gyro_core.c
      5 magnetometer/st_magn_core.c
      6 pressure/st_pressure_core.c
$ git grep '\.num_ch = ' | cut -d: -f1 | sort | uniq -c
      6 pressure/st_pressure_core.c

Interestingly, the pressure/st_pressure_core.c uses both assigned .num_ch
_and_ a sentinel.

> Since these structures are static const, both "ch" and "num_ch" are
> fully initialized at compile time and available immediately at boot
> time.  The only accesses to the "ch" field of "st_sensor_settings" occur
> when assigning it to "indio_dev->channels" during device probing.

Heh, so the bounds check gets laundered. :) Even pressure:

pressure/st_pressure_core.c:    press_data->num_data_channels = press_data->sensor_settings->num_ch - 1;
pressure/st_pressure_core.c:    indio_dev->num_channels = press_data->sensor_settings->num_ch;

> Because "sensor_settings->ch" is never dereferenced or accessed as an
> array, adding the "__counted_by_ptr" annotation does not cause any
> runtime panics or false-positive bounds checks under KASAN or UBSAN.

I would argue that either __counted_by_ptr has no use here ("accidentally
safe because no one dereferences .ch" isn't a great justification)
or that the accelerometer, gyroscope, and magnetometer sensors should
have their .num_ch assigned correctly so that the "contract" is correct,
even if nothing does the deref.

-Kees

-- 
Kees Cook
