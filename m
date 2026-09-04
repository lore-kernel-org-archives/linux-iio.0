Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C128439185E;
	Fri,  4 Sep 2026 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563386; cv=none; b=OAEYnaCnDSCcHy0p2LW5jC1EgnBozqPMeNanjElpmL8FM237akK/WHk+bfcxPmmpNNhZUrI6jGDRVmdxUeR2tzUvuqrflb6jVazJQcBReON0ZMiMN/0VzUm9yBWtNdp3ElKu33duLrzoazb+bhLF6Wd5lhKc7PdcuuX+tJp8sAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563386; c=relaxed/simple;
	bh=H1eNDN4RfbW9JOTG4EgqwTevIyejMTd/5sSXCpkCFLE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=jGnNtVo2KvVbOv9b6Ydc5xx3qS/R6QYf4EPIO8KC6d1ge4obudol3tZm2ybIKiyiCOZiOk4bSu3lbKqW6XKwQJ+QXCaBxgQzoL4oPbMNIHwNuj77cqKzNWube3QypOxPCXZ4Xsjtv1rasgQurdXQiffFDSBdozlex6eEgvpZl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwYcNVUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwYcNVUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178531F00A3D;
	Fri,  4 Sep 2026 23:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788563385;
	bh=+rFXI/v2/zjLvXmCGwWrZZT7dtJ08vZI/FdYiX2oxZQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LwYcNVUt3dFLGkpl/XJ80jjVJCiffpVTttamLhSe/FDqtJBRFFuZg5fWzUuEElQjN
	 HpMkWhdQtgzQJDo8fvsR8DwV7UVw/93d5oCD/navMoajHKJkRobtdE3A7x3ImM6DY8
	 dJa3ol8lIwi2EijByGRTYixEXSBUx/C7gDxYzZbwPrlNKRq85pZVUT0rwiPgrjbES7
	 GxhNlymFnfd6ccZT641BwXBA0/QSqs0a96NzCqG5LmtPrteYZ4tj7wwg/zO/Z2emTg
	 jUvKpipjdzD09Bhwzmm7eeMcXueSD/z9oB+fceO7SE1trBU+2QytWUzldCJuJ/TvEA
	 8hF59ICTDtn2Q==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 0/2] iio: adc: add MAX40080 current-sense amplifier
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
In-Reply-To: <20260831134334.196359-1-stefan.popa@analog.com>
References: <20260831134334.196359-1-stefan.popa@analog.com>
Date: Sat, 05 Sep 2026 00:09:25 +0100
Message-Id: <178856336528.3402141.5961406917373699870.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=625;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=H1eNDN4RfbW9JOTG4EgqwTevIyejMTd/5sSXCpkCFLE=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqm0+oObw2Jy18vcfXNcSfk4yP1Vg/f2Hkuqzn1
 39vF20iL1KJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaptPqBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiP9FD/95zIaHogC/wS0lHo0ZB+KXVjsBfWkil3cXw+7xnv63Lxw
 p9jGiVbnDbq7TeEhjtGYce+LZdXoqkjSzYI4DHiT+5/QRo0tPYVFTUpAKbgrntTQvMmLD3K3FzH
 NlX+PWWFhYHvwJ4I+YuZ1gzQ1UJFUU2we1Rw0pkW3TjwJSZwC73Ybxm2TILlmS/pkMSeZbksuZn
 uTmZ98xqvRzxheS+Og0QR6EZ61Kv0athLdD63JPTbntMd5VuIW2dhwJjoKafBfRofckkTie2bdU
 +y7FP15O04J2OqNMZndA0nm8C+NYv5QcmEB9z5K4iON7E7QKS0ZyM4DwjNIdgy8bVIYbpdEfkPs
 k64KJibVsfXPkGc7lOSIz54iynEw2i14fkZFIR/K08xOUgqFhOSCJEwnyyBMoo2teMVYhBtw7u/
 MpqdCvx2ibxLhvcwX8WMd/sLd5eFopSosNczcWKo9dOd/eu/maiBulDDusMv/RzKGVwor68KZdA
 YtWgMLUMWdn+zAlPG6XkrzPat8WPUgcvIUbvX+G2ZQcdeKoBa92pKAaY5Nuh4aQNwgNmO3s7PMa
 2vcv3xxnG4emwc+pGDfeo97Uhs/MW3YH3UXf2RKd4RayjD7a72rLFf3u70AmWZp4IMkmStcgQRD
 ipUusDD6guu8ws00a0fi1J5zSX8DpIiIi4wu4Sw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> This series adds support for the MAX40080, a bidirectional current-sense
> amplifier with an integrated 12-bit ADC.

Applied with a couple of tweaks.

>   - Buffered capture support is planned for a follow-up series -- each
>     conversion returns a matched current+voltage pair, which maps cleanly
>     to IIO's buffered/triggered model.
I'd like ideally to have seen this code as it is the main justification
for not going with hwmon. Given you've been working in IIO for a while
now I'll trust you to show up with it soon.

Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
