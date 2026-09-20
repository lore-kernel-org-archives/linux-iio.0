Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3941A8F;
	Sun, 20 Sep 2026 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789863990; cv=none; b=RRJ8TkknCOx2wuVldqGvSosoofK/sAwO3kg1P/EdCJrWlzpzZ35W4Iq5D2DMKSlKue9jeAIdwAY1lO0hTLbq62sdj6r+tqqcvbSl9vPzrF/wiImSsFtfecz3jSML+CpC39fuPe25XyrHFEeoVkQKg1VzrleU8h7l8g+vcgajEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789863990; c=relaxed/simple;
	bh=h4pbiX06FgkE5ryjHXJwIBu4aut2LCAVM1nbaqNqirY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=h6IbDVxJ333mlfppEizqjOc3KlU1rcwzRnev0mqsnHeFftg3vofm5t2V/+X5dOUrfNjJe5MsAsMS9/IAM52aWT9J3Biw1/f3cs9F739pWOVl2Bn0tqwrDpe/xDGJGmygfYgd/jbbUjrTvGw8Rm0Yz61TdvqLRGSt0HiPVI/BPks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2TwUNIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2TwUNIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8D11F000FF;
	Sun, 20 Sep 2026 00:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789863989;
	bh=1hHhXXuxsHCRvPLheKiLLcZjE2LWaxZVj1xaUI5h/c4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=V2TwUNIeZwyc+1M2C4Vdn2L0xRsKlRt5ELNW6pD2+M5tgQ9FmE3DNnAH8jGGgfNQ3
	 DKKqKRW2prziKT5rl4wKKfCNF9SOInZLVyBA0dgiVwAF9/G222nUkL/64+eY5y23Ur
	 ggkruUDmWyWWcA7m4BCvoVt39zuAdmPlFwl2XtXtw+6mgYN4YuvGf6fkJ6Ab+W3xOq
	 L9LeWz/n6L1P/DViWFw+CPUizLIFM0neDE2y5FPfualdjKXq+0J09DJu0twBWc+jS5
	 n8fmR9Qqm9YyDGlzEoTd/S30aW0/rpFfUfF1pMhgRbSG49lnXnZCrZk+vCT2GJQdYV
	 7Nv5m6h0lkUDA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: light: add as7343
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260919235145.48273-2-marcus.yu.56@gmail.com>
References: <20260919235145.48273-1-marcus.yu.56@gmail.com>
 <20260919235145.48273-2-marcus.yu.56@gmail.com>
Date: Sun, 20 Sep 2026 01:26:11 +0100
Message-Id: <178986397173.706584.714197937565481606.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=960;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=h4pbiX06FgkE5ryjHXJwIBu4aut2LCAVM1nbaqNqirY=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqrygm7YnNJLQ7qcQC58ww9dCI7vKIP+EkbE0PK
 HiX/ievXZeJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaq8oJhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiFWAD/9gvWoKvxFpsWhkaqiG6hak7hYeu5SpY2iAVH6lW5iXlDb
 W2QrxeTsZYYTWM7xMg1uD7Al0rvkdU7wUYxq17b4HWb/JznFNLKRfupqcgFL0kRbgkQHmkn2HEM
 k1e+6yBIjjOGa5ccQm15UKlPSodwGmiuTgq4mQ1leZT9I3SGlnxhtBhEkciqzA5LmyyWOqrz38g
 xHLnalLyRqLXfA+b9/Bm83d8poCuZkyfGcXcHYn6tZl7Fq8Qvd5fjfZwZW/cxke8GmGV58tPq6C
 s4wUIr2y/ZDeaYyU+3taxjgZcJPX2sITmU1AGuYZhy1HdUf8LGDmE65gI69dQB8jV4dEMo73/Y8
 rsoskyYAKEvDRfP9jMKitAexErM0ekp0G8KxUxBIbrJF1/lK9Djf51ePFq01OzvTxXVyg1NVvlE
 wTf4JPCR+Gx/2+z26cUcFRglFQioEkbkkHAjchvs97CQdhcDU1UmpOiEc5st+tdVWptps/0QMJk
 HgFWpOgfZZW8SrJQqbl+YVXt1RgdZpOvd1iIk/BqsPpWdMc0FMH1Sd6T1mn0j4RMpv0Mo1R+75g
 jxMv2AsgGY2jMPX7WyEZbMwfJMRJ4uWyAZXfw9NT4L78+bDfyyJdZjrD43PfSiyIPU9JOCbxF9K
 uT/wH//MkybjMacLEk27iloSDdS3Trfq5sT+2zQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
> with i2c address of 0x39.
> 
> The GPIO pin is not described because the datasheet does not document
> how to use it for hardware synchronization at all. The GPIO register
> also has no mode-select bit to isolate the pin from the chip's
> internal control logic. Exposing it as a generic GPIO could result
> in kernel writes being overwritten by internal logic.
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>

I've just replied to the earlier discussion about led-max-microamp and
$ref.  We need that thread to come to a conclusion before we can
move forward.

For future referenc it would have been good to capture that
discussion as ongoing as part of the change log and cover letter.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
