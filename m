Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165F37EFE2;
	Sun, 13 Sep 2026 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332732; cv=none; b=Z+QqNrXitJyH5nnSq4axWva6QT7UCkTcdddHIl8qrL/Yyki1N6zhLTjQ/a41Aac0qAIAwY9JTYDie1Wh76Z+hztTKTwWnUMlSVf+rDnjkgE5oP6g1+Gg5OtbQdQCo8IAz4MqzmpEaXV9bO/gLMYNjA/X/10q2za+Lbzdzole6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332732; c=relaxed/simple;
	bh=v6V1pz3xsafbSNASw6n4d1HqeaQLhJ290E3rqDLkKBM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Q4XcBQiRyJwHygaVdxEP8+agT69nJTKURKUH2FJic73bo1X0bLX/AcsYM5cvcoXfVaDM+0BHB3QuOfGDE3nM9KTpBL1zi90jd6WA3INqDEyYTRUcYkgx9f5CBmQ4ApONpuCfuqn8K5hTDxgZFRKCdC8WwHr9+0cEpeO0QKFb02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCKhbC/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCKhbC/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB6B1F000FF;
	Sun, 13 Sep 2026 20:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789332730;
	bh=FpP6tsayY62VOCyrRwVsVbv8i9B9cduAzeh6MgDO8M8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=VCKhbC/67bCPh2HdYF4Nd2f2vt2yBW0XR9HZNOvC8JoSX2IJLOzjhIG2deru/DPrT
	 oZcRQsTrvtB9mWTnojZ91lBIBLwpZlg8603XX6DAWxfaTUjuh+znYKTFPBuUh36oyK
	 SVsNNeUN2qcUcE2qE69Zo6msJ+SbcESuQKBV1uy1oLT2k6ddcAwqK+EXN4d2Ka89SR
	 NXjE8P/HyCSCCRF8O95eBvn4ijoBY99sEAL3lM7l68rp0LwxotN8fHVhMCdorD8AlC
	 ed5il49qfLiVNCG1dps6VOzv4O72b2v+gxQhiC0ykZzaDGbyS/NfbADy10J0Fiz6zj
	 hEIxuURTCtE/w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 00/17] iio: adc: Add AD7768/AD7768-4 ADC driver
 support
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
Date: Sun, 13 Sep 2026 21:51:54 +0100
Message-Id: <178933271415.413489.2874987642406336139.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=344;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=v6V1pz3xsafbSNASw6n4d1HqeaQLhJ290E3rqDLkKBM=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqpwzsR4hh8C5q0WNsfC5pQRezY+4Ruvd+4pmSF
 3TxXsA4ddiJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaqcM7BEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiLsSD/9nGt3dgpBPug4PmDTMyv4N0NdslrpHz0KFzD0M3hNXjOf
 Og7Y4U+ratya4tU1TIooFqhOTY+MpOreITQcmVcKU8KjWOibvzxV7WR18iy0LFyJ9C9XcGxKWM5
 8gWRsqDxAf+MCPHquLmDqLSz5pQJJcUzpGEqLF9Ume/GhOGTRX4U1iWy/4O9Yif5FakCfBJu2U2
 Quo5Z65e0C4pRcib9VtnVbIPhi0X40EWkkGU8IorkTFXyYMo+hOVOLrh6VBqKW/EwIkdGvdQTwx
 V7n8FVSTplHqANN+EAP/emHh8PvU4mANpoIOAdV15hM/8gi4xIYiuoKAmaZn9fiYR/yPeE2lTWq
 xK358qXIpsOKkGhqTdoeRb+i15j95SJhLkWssYqzmJzbFD5tDvj7o7m/qVcl1+p0seuTY7JTZj2
 FDvcBqRQECIZP99BZYCwcbtmGOlpPbVPWxXo5DFxD9ZnxZYjOwJh6BbLIDuET5FIqK9tOi8MAel
 9GxrEkO3efDy3JNw69dyU881HOmFrx+Y3RzOkodDKAQojM13aztzDlh4L8FWih2Aaf4DYtkyxY7
 zaMharY4ilfM7UfeJhm5d2XqbNI8WLQCAM8/nyAMXCZZcFh5WGbDK899A8WvueJ1e5LVA0vdg+V
 wlK5NFtIAW3P4o8CwHl28hUjtAVpQbzc8IFj1ig==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add support for Analog Devices AD7768 and AD7768-4, 24-bit simultaneous
> sampling Sigma-Delta ADCs with automatic power mode selection.

I only had a few minor comments. In general looks very nearly
ready merge.  Hopefully nothing else shows up in v8!

Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
