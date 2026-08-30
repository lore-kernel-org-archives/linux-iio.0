Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0591D5AD4;
	Sun, 30 Aug 2026 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788051137; cv=none; b=Rc87cbXGtEdpSvAGRszTnc/mLPBwsk4XUZUfYEKHoFmSQ0zMVbhP8V1vTNyxfXN9X6B/ShF4Hn0GS2XGSKdbMu9g9LRqNExBme5qbrUJPs7CY+99ei36zsyIVY2zcWnxzM8aZ/4ZJaha29CER6gZ8hoCoN/t7xgwNTE1BDC+YYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788051137; c=relaxed/simple;
	bh=LRu1q11mMZxTGtLsfQAiw/NFsi+a5ZRJrmhiaAIAC2c=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OEoIjWd1S5DSEYAIYwWTP5+m6xbfxt/88YS+o909BOGRaNBx2+O/MdZhElmVKCXAXuOaD+7wBmJrJsNUJhOFdASg+0mQrwbprYiyk/xXZRg6cfc5IniqDefFy+soJrU03/Nd43vTgiQ59l9Dn8VXD6/zwtvFLWqi5DC/64ow70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMxlimcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMxlimcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AFB1F000E9;
	Sun, 30 Aug 2026 00:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788051136;
	bh=6Y44Tw889jZtwseR6Jk6Nei2teoPvq7Ug+NVgWC79Jw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=kMxlimcwatWkKYblsCZsVCPmi3qWqVsXBZAGbCnF2oqKp4Zo8Zf7c1UDYOEZZS11S
	 TJWRh1SjTr3p1pRL70/w2tTs6hW6fOG+CNMhICWe2JZ9l6f+f4x9Kak3oysGfZMxVy
	 YNd72OVXeWSLqksZEUNGMPKkTGyBEL/HytHoHkyMhmj5GHe3Rr354BF6tgvAtqr93S
	 2SFlcAk/k49KY5s2ON5AnlHKycZHfDysGI4RxBvSSEVCiLUPy9/18tflUz+xJT3bkY
	 Do2VlM2GOulv0FlDgKg+oei9pLJoLI0fDAt1mgPZt6CF/qdG7BfxEA6NR64zOAt6NW
	 umdGfgruci7Ug==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 0/2] iio: adc: add MAX40080 current-sense amplifier
 driver
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andy@kernel.org, dlechner@baylibre.com, 
 nuno.sa@analog.com, siratul.islam@linux.dev, u.kleine-koenig@baylibre.com, 
 linux@roeck-us.net, joshua.crofts1@gmail.com, ciprian.hegbeli@analog.com, 
 krzysztof.kozlowski@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260828083119.54495-1-stefan.popa@analog.com>
References: <20260828083119.54495-1-stefan.popa@analog.com>
Date: Sun, 30 Aug 2026 01:51:39 +0100
Message-Id: <178805109906.2786293.17524353371768518972.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=825;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=LRu1q11mMZxTGtLsfQAiw/NFsi+a5ZRJrmhiaAIAC2c=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqk36dqUJx99FG/wtAzlOHytwDHdFneebSxTdL3
 J+wPgVZAYOJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapN+nREcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiFbAD/99/qdGDfst3k3x9hu6G5x4TmMDcN9bZm0bLDz8uolbmJ2
 A3fzFoXvzRrA1YAQKDRsZ6E5WpBdifDR4PRiZtkn0nxuKvfHf5TdLoZMj9hs9/ZlEaAWJ3d4jWf
 zc07J2DKjmAr9C+yPU2FvvIkKShM9cweOTBjHmpTQDN7xsbcXpwBZWpmqcI7SYKs8HY9TAi7wOk
 PZ2OnlWbuCkaVHo0SixoUlaHoj8VotzxV3oUVdOhmWlvrxeGSlaDq1vRowsDTCZRK0pOcbTIJ+u
 ASl1aOWQ9NocXCzNBozvYzMXgBlDTX0DoBwpyJLlN6MLSopvZxwox5E6pfGF4L5kQb758Ioqv9X
 fH6/AwxTOsGQO6kj4j1ml5bsdzKfRFwNIaoZwb+veAJ2/60h9JONamqH0dVCb7YU/N16VS1XYnD
 zATbOcy+ojLt7uMWoDFEsOJLUCnJ7ahPbI64b6J+dEDYZSLb2v8ITkh2MlQ/lw6CUPit9tUYfrf
 MtgXyuB1i6L2lmuXGcwsOWhQl+HWGplCjYEYyETsz37uPB06b2dwUS0eUFZLrI4lv5VYFQcUJxF
 ORbeDAES7Z/Si4bHWx2eA+AQjsq3NL0tAfmGseR1HS+wqCBNLt7Zax9EN+Uf8NUfMlOxvmdI47+
 jXbxaEJ/qPXMQkw90ki4KbOzwikl1BjZ3YssQ6A==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> This series adds support for the MAX40080, a bidirectional current-sense
> amplifier with an integrated 12-bit ADC.
> 
> The driver is placed in IIO rather than hwmon because:
>   - IIO's scale/raw model naturally exposes the selectable gain ranges and
>     lets userspace apply the correct scale per range.

This one is a bit weaker as autoscaling is possible (if fiddly).

>   - Buffered capture support is planned for a follow-up series -- each
>     conversion returns a matched current+voltage pair, which maps cleanly
>     to IIO's buffered/triggered model.

If you have this ready to post, I'd prefer seeing it sooner rather than
later just to strengthen the arguement.  A link to a repo would do as well.

Anyhow, just a nice to have!

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
