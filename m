Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956958;
	b=VktB0uZbeMyiiwM+XZSrNpof3yUlzbEdgjAQssFN9F/bNS3IdIhvHQqRuR9s2tHMsSCW
	 0bcqMYaFo07LU43SofekvK4R4JdLjkZQaxwNxePWiiW/aXqwDL21FqFkvvqA3Phpmxe0C
	 mb0tckw/Bu19wj7sD+YRHlYNUifTtXAeXYFDh91u1j6pv7GgWF1t1QT2GsPk8fBpWPJyA
	 sbL6zmRYQTZeeJU+ncEMSMF2yRb0dH7WAK9Nc8pTqtGIz59eikGDBNLpfSapCnMRrXQWw
	 /9u4cpzHe4xJZB538YWeHF+2migXMyabXCBZ9ClWT1q0EURIoqzNZf9fM3e76Ogpjqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956958;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=D4CgicPmSEsVHLuBA6xfR1jgrxPW6tB2c2qahPK26hw=;
	b=wLCm283DdKf5zkpYqXFr2OsbZ3ndPRK/DC5n8cAYCC62a7mCiqbc6+SRRT7+cfxbLP5m
	 4vI/oJA8LbCEHDdYZXo2aGUII73SudOMC2l3DIvFqn+yBPMz2X1ZzwzEsMdhlP2D+Z7VY
	 Q3piKQHtqhtTDH6PlSA2xWFU6qg+CZUodCBazz17eV67x89yzZEnlDsR4MBdly5g8/SwQ
	 xMYhHxm+qNNBzwkIPzvy/pH5TtHqWBtvluXKhHMLTDZtHouHJEgB+eQEkNW9Q/REdqyY+
	 0xxBYfHl1++pC/9/trT2uSQch7bbUqKeNqqBar5HsjLdPOv+43qik3bid/9GsmGiXSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrl5jBjk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DEF606D808;
	Fri,  6 Nov 2026 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrl5jBjk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EDD1F0089F;
	Fri,  6 Nov 2026 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956958;
	bh=D4CgicPmSEsVHLuBA6xfR1jgrxPW6tB2c2qahPK26hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jrl5jBjk4QkB0weWayMYDtKpOcbZVxw9GUH7dREHmZtjYCu3IzyTCQ8P6lAQWydw5
	 SjGSytGp1ENxJkOtRqM5EIg4VM9YilcWWRGcFIKgXvatVuKSGKiAGP0LjPvbr246eW
	 JIn/I1ueo0P+kJwfVgcf+i75dduSsONfXRtNN00oNtf/vwVUhDcjQpd++HvYDUVCiz
	 zDiDcuFMkKfIoH8/PJpz30JiQhJPOqSq44gkSFWQKJaLpbkdadWze5zs6FAKhK+j8r
	 qEW/ThnIriClbbH7j0zvx9WKp1FkPJwBnyHonyvZD7N7vCaT1YuEzXPAXpCvPN0d5h
	 14HrPkSL3YSug==
Date: Fri, 6 Nov 2026 10:22:17 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Satyam Gupta <sgsatyam@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, "Nuno =?UTF-8?B?U8Oh?=" <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Benson Leung <bleung@chromium.org>, Guenter
 Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, Enric
 Balletbo i Serra <eballetbo@kernel.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec: Use platform sensor_num to unregister
 FIFO callback
Message-ID: <20261106102217.3bd67592@systembl0wer>
In-Reply-To: <20261106071904.142937-1-sgsatyam@google.com>
References: <au1FF5K9EALuqnNR@google.com>
	<20261106071904.142937-1-sgsatyam@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Fri,  6 Nov 2026 07:19:04 +0000
Satyam Gupta <sgsatyam@google.com> wrote:

> cros_ec_sensors_core_register() registers the FIFO callback for the
> sensor number found in the platform data. The matching cleanup action,
> cros_ec_sensors_core_clean(), reads the number back from
> st->param.info.sensor_num instead.
> 
> st->param is the EC host command buffer. Drivers fill it in under
> cmd_lock before each command, while the cleanup action reads it without
> that lock. It is also set only for physical sensors. If the field holds
> another value when the device is unbound, the cleanup clears the wrong
> slot and leaves the callback in place, still pointing to the iio_dev
> that is about to be freed.
> 
> Use the platform data in the cleanup action too, and pass the struct
> device pointer directly to devm_add_action_or_reset(), so it always
> unregisters the slot that cros_ec_sensors_core_register() registered.
> 
> Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO")
> Signed-off-by: Satyam Gupta <sgsatyam@google.com>
> ---
> Changes in v3:
> - Pass dev instead of pdev to devm_add_action_or_reset() and drop the
>   unused pdev local variable (Tzung-Bi).
> - Move the note about out-of-tree triggers and how the issue was found
>   below '---' (Tzung-Bi).
> 

No, don't send a new version of a patch as a reply to the
previous version, it may break tooling like b4 for example.

-- 
Joshua Crofts
