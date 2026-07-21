Received: from MTA-11-3.privateemail.com (mta-11-3.privateemail.com [198.54.122.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE03EF644;
	Tue, 21 Jul 2026 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654236; cv=none; b=tJxEpyhUG2K9sRetMyZwdh9R/NWCIO+zAEPqbKgB7TtaEGt0cp1qVkjN8AkzYJUpXIPG6Pbu3PbwVTiLonvMO7YJMJiOamLFXx0TGeGSv4GDHWdo191/0C4wPT4RQRlcbq0bow42pbiSfRoF2fMwg1fY4y0aYpDvld0Mscen74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654236; c=relaxed/simple;
	bh=koROrrEYQO1XRYreueMzUi9aq45sqTe1/heBsm5ssHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+7nsipx2Xq80rvzvdrsnWy+pjLWA4OoeVQzTSh9fTuKmEd0Ynwh4TW8n2n2khrB+s09FT1AruF9VqUx37KpXRSBidy60zDFBDoYEJQ+SkkonL2npMc2cN1kEZImicDTXh6DdU8GZRt6uzkSAVUfdqoRBDyg6VMkIfPgzUokXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-15 [87.215.145.39])
	by mta-11.privateemail.com (Postfix) with ESMTPA id 4h4PFP3B5mz3hhTr;
	Tue, 21 Jul 2026 13:16:57 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Conor Dooley <conor@kernel.org>,
	Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add icm42630
Date: Tue, 21 Jul 2026 19:16:47 +0200
Message-ID: <20260721171647.26128-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721-lethargic-purge-e3cfb3c50677@spud>
References: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net> <20260720173411.82979-2-jorijnvdgraaf@catcrafts.net> <20260721-lethargic-purge-e3cfb3c50677@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 21, 2026 at 05:01:26PM +0100, Conor Dooley wrote:
> On Mon, Jul 20, 2026 at 07:34:10PM +0200, Jorijn van der Graaf wrote:
> > The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
> > found e.g. in the Fairphone 6. Document its compatible.
> >
> > A fallback compatible to a sibling is not usable: the part reports its
> > own WHOAMI register value, which software validates against the
> > compatible.
>
> Why does software do this? If the whoami is the only difference, the
> software should stop checking it.

Whether the whoami is the only difference is exactly what I cannot
establish: the part has no public datasheet. What I can establish is
driver-visible: the unmodified driver has been tested to drive it
correctly, and Jean-Baptiste confirmed the chip is "similar" to the
ICM-42631 and "can be supported by inv_icm42600 driver without any
modification". That is short of knowing the parts are identical (the
family has precedent for real differences behind the same register
layout: ICM-42686, different full-scale ranges), so I did not want
to claim full compatibility with a sibling.

As for the check: it is not mine - inv_icm42600 has returned -ENODEV
on a whoami mismatch since its 2020 introduction (and per-part config
does differ within the family, see above). Since every released
kernel enforces it, a fallback would not probe on any kernel already
out there regardless of what we change now; and even if the check
were relaxed, a fallback-matched part would bind with icm42631 as
its ABI-visible name - so the dedicated compatible is needed either
way. Whether the check should become a warning is
Jean-Baptiste's call, as a behavior change for all parts the driver
supports; I did not want to gate a trivial ID addition on it, but am
happy to send that as a follow-up if wanted.

The commit message led with the driver check where the real reason
is the identity uncertainty above; I will reword that in a v2 if one
is needed.

Thanks,
Jorijn
