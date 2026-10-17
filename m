Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C74CF468;
	Sat, 17 Oct 2026 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279405; cv=none; b=jkcqVMh7pu3I1JzvvC5gGNxMusq+P99NN6tG6sQrOEdgzFeAz/HKVDIAWbrkkW6jbDJ0+5bVToG6Hj7S06AevuRLbMVfyXQT+GpWKN6Iz8Tx8F9bJVOFLZ75QpnN0NLcW1xpjBTfZJlhMU6MThFEjYmPV/MXVz3tRLUqLWYuZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279405; c=relaxed/simple;
	bh=ge1sX7tqJ5M5YkiTlKE95R7Z2sveXhKCd+120fLUy5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfCZdS2Q42KPh6GECtIyY13Mq3rObJXstx7eSiIuLCSAfs7y7SNYm4AuZE+3417vta8FQ7aOk9olXVd3ZCyTU4OxPBeCfFbplD8biXBJm05c/1YnmFXdLEKhkl5Cujt6Lz/1RS3aBfr4YIqS1nMjBRRaW/o8biL+OKUbvLOmxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYKrHtsM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYKrHtsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4F91F000C4;
	Sat, 17 Oct 2026 23:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792279404;
	bh=2ARB+WOrEsDqvkcNsapN1ZdF/DS7I1AlxGQkxLGUk0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BYKrHtsMa+9hNug3b1yHDIKrGsMhp6V8SGDANCjjcTi0hMTCXRjoC9uGTtT3y1Koo
	 dShNpGdlxCyLPpx9GIVQigewc4cpE8wRXP+/N7rFOqZSJJI3XSrBcFTbySAHgzMM1l
	 9yANNwRb2saYmjqO62ISZh0uc6gW/NnbnImm6i5OiZ3eYGm5PMDBGI7c+4P+Pcpb9B
	 ee0MNzDSFo4yYquI7C0FG25Y5s1MVWa0hv1BsAk5ZGx8klRaLp1llN4X2iws3J5o1Q
	 06RhwrR7K+mhUMBBU8M0YX2uvGRuun5XeChVIs4JKp0ootZuvY8DeMJ5BEV+BhWOHK
	 lwWLcc7Gj5CSA==
Date: Sun, 18 Oct 2026 00:23:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>, Shi Hao
 <i.shihao.999@gmail.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Add support for AS7343 multi-spectral sensor
Message-ID: <20261018002318.129a2bed@jic23-hlaptop>
In-Reply-To: <20261013115639.167433-1-marcus.yu.56@gmail.com>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 19:56:37 +0800
Chang Yu <marcus.yu.56@gmail.com> wrote:

> This series adds initial support for the AMS AS7343 14-channel
> multi-spectral sensor.
> 
> The sensor has 14 optical channels (11 visible + NIR + clear +
> flicker) in total. This initial driver supports reading raw counts
> from all 12 spectral channels (11 visible + NIR) via sysfs and basic
> power management.

FWIW I took a quick glance through and have nothing to add to the bits
others have hightlighted.

Fingers crossed, we should be good to merge v7!


Jonathan
