Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4E43E4A2;
	Tue,  1 Sep 2026 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277453; cv=none; b=Oz3+xcgUszSknJJwrBFwcMknRjnHoPWECE8xE5tgnfL8cRzBizjdA09NHLLJyCuwESXf+T96ES4IoSIqONrGYjHdDDN7xVd+V/x12A49U/nXL7hNqPARHNY43YgNnWo0TdBChT9s1sVhMbX5QHIEEJsmFVl9NjTay/ruTJGOaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277453; c=relaxed/simple;
	bh=jJeAjAzSXqJMGv+Xwis555DWb1EkiBV/ikq/XqgToSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I02s63ajKDRlVQcyGJvtHTv3J1SSkorlXOqY8n7EgvUwerDKNxsJ8+NqrE7gFDO3CgWeoJCdigtGlYu13pjWJSfAIbFWWUlC5LyscQ+FBmhbgAih6QvO6M9Yatvgb7t9N5w4LJUabnpyuiK3QJCkdO1Dmi9QqFY5+aFtNVcwgwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9V+tqOG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9V+tqOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFC31F000E9;
	Tue,  1 Sep 2026 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788277451;
	bh=pzqa6Cmokg/fkJYMIhCcVeUP7klHo3a5uK6Co/3lh4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g9V+tqOGIu9yJXCNqUhe93hyux1yft+yoYSFj6jAQXHgYpqcMyHjgXisqsl2CS/MD
	 ZSc9Sw0gD/IkVE/IGGMQSmXaOMMzijR82Cn7kO/RiYakUKMh7UzmmZPYCu3kXuJ5km
	 2oFjvYpFtZ/7g8fOOck5MPq78AqZDjyhWgjvXDDqLmBHW+x5ry/Q2jNtOPuq7iqXzf
	 a6TCjlTSPuY09sFVutwM8509X7o8Mf92Wad61Q4hTnIZEXP48YnYI6l2TY1uPGyF0L
	 jMV9Ssyj3S5MTI1vQvCMONMxpJ78Wv4A3LYv2Qo9riXeXUbtTKswByF7qjhvsivotG
	 tqZSnp6zw36bQ==
Date: Tue, 1 Sep 2026 16:44:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, Uwe =?UTF-8?B?S2xl?=
 =?UTF-8?B?aW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, Linus
 Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH v5 00/20] iio: adc: Add AD7768/AD7768-4 ADC driver
 support
Message-ID: <20260901164403.58580dcd@jic23-huawei>
In-Reply-To: <CAMRc=MdLmCqSfxtwQcv+gHVpAUV7hJB8UQRF_aE8i60wf6mVbg@mail.gmail.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
	<CAMRc=MdLmCqSfxtwQcv+gHVpAUV7hJB8UQRF_aE8i60wf6mVbg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 01:32:45 -0700
Bartosz Golaszewski <brgl@kernel.org> wrote:

> On Fri, 28 Aug 2026 17:30:23 +0200, Janani Sunil <janani.sunil@analog.com> said:
> > Add support for Analog Devices AD7768 and AD7768-4, 24-bit simultaneous
> > sampling Sigma-Delta ADCs with automatic power mode selection.
> >
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-ad7768-4.pdf
> >
> > **Device Overview:**
> > The AD7768 is an 8-channel, 24-bit simultaneous sampling ADC. The
> > AD7768-4 is a 4-channel variant. Both support configurable power modes,
> > programmable decimation filters, and a high-speed serial interface with
> > 1, 2, 4, or 8 data output lines. Per-channel offset, gain, and phase
> > calibration registers are available.
> >
> > **Features Implemented:**
> > - Support for AD7768 (8-channel) and AD7768-4 (4-channel) via device
> >   match data.
> > - Automatic low-noise power mode selection (fast, median, low power)
> >   with associated decimation rate and output data rate tables.
> > - Per-channel offset, gain, and conversion delay via IIO attributes.
> > - SPI communication with custom regmap bus for the device's protocol.
> > - IIO backend integration with adi-axi-adc for high-speed data capture.
> > - CRC data integrity verification over the serial interface.
> > - GPIO auxiliary driver to expose the 5 on-chip GPIO pins.
> > - VCM common-mode output exposed through the regulator framework, with
> >   runtime PM management while the output is enabled.
> >
> > **Patch Summary:**
> > 1. Initialize the AXI ADC state mutex.
> > 2. Add the AD7768 and AD7768-4 devicetree binding.
> > 3. Add the IIO backend CRC operation.
> > 4. Implement CRC control in the AXI ADC backend.
> > 5. Add core AD7768 and AD7768-4 capture support.
> > 6. Validate the master clock rate.
> > 7. Add the power-mode configuration helper.
> > 8. Derive output data rates and the data-clock divider.
> > 9. Configure enabled channels across two sampling profiles.
> > 10. Expose per-channel sampling-frequency controls.
> > 11. Expose per-channel filter controls.
> > 12. Wait for active digital filters to settle.
> > 13. Add per-channel offset and gain calibration controls.
> > 14. Add per-channel conversion delay.
> > 15. Expose the VCM output through the regulator framework.
> > 16. Register the GPIO auxiliary device from the parent driver.
> > 17. Use regmap_test_bits() for single-bit gpio-regmap reads.
> > 18. Add optional runtime PM support to gpio-regmap.
> > 19. Add the AD7768 GPIO auxiliary driver.
> > 20. Add driver documentation.  
> 
> What is the merge strategy here between iio and GPIO trees? Can patches
> 17-18 go through an immutable branch in the GPIO tree that would be merged
> into the iio tree?

I don't think there is any coupling between those and the rest of the
series.  Janani can you confirm if these two patches can go via GPIO
whilst the rest go via IIO (without the GPIO patches)?

Obviously the GPIO driver won't ever bind to anything until the two come
together but build tests etc should be fine.

Jonathan

> 
> Bart

