Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907004;
	b=qwPAEeOQGYc75BxOPTJPOHZiPbUmAsyrSHO9QDmAHKW+P1l9cgyLK4B155l1t6ufcKIL
	 ph3jHW0uxLJ/2EFyYiRCfa7ioLpx/5dm+29UR2suBexQrolQYHDcDoziuZAgtE+5Ogkbe
	 iblBt5Vg82JMjwh0czuX0+KKj4MW0DtnfCaBVCECW2f2XqPNv/XYRetBtAdmMFaTYI8oK
	 K9GQasyAYofLneO2feo4KlZD4TmGAXWdENWQ9qyuFijX+i+gdEAYKGfYIthEl+t/G/Rzc
	 ogbOsent5j9Lh5y7yiGPiPMFvlhcN50qE7t6FIu7xpeStsy4Sde5saNZI8NOfpgR9Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907004;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ENLb0c995WFDdbTZ76+5KazXvgIj1Nkaa6Go10nFBrA=;
	b=MLaB/juyaI+9XqKOtBzr03K110JuXec14dSAW6L8CziCtqk0r08vSpvJg9MhyL0FsL6C
	 Yiu3+8kchV9xwZoWhsBXUKOA2NBy7fLYxcHpqRCcQihG7lId8n/BaWRj4QqTOh07wy9gs
	 6oI/kvQglAdVZxsJC3LghpLJpRVuHnnv4nrSzririXvImpndf4vCCwcL413WZxExvTtlk
	 HEj6frOEHzZhHFBRoXqRuPcIEQxfhVBb0ExmfUkf+NclScj1cg0PoVrGONbZAK1ACd3N6
	 +nBbdn8OMiT8ljKM2aXvQkOBoGZFfNO2KDWK4uvj73Otw5MHq5IGolOqbMCVyOky7RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UBZB0YyJ;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AEF606A323;
	Tue, 17 Nov 2026 09:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4AEF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UBZB0YyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794907003; x=1826443003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CwpqPPX9+w3rRm+quPuzhQxltj10PfTCUhv8FQQd3CM=;
  b=UBZB0YyJwRlDxbRUVaX4g8YVS4j6Un9xY57ibcUu9cc8j1/ZZkFAf8m+
   quO6F6jOQTo/LmYJsy3uB6bIJl7sTaOYkH5Jk+8pM9TtG5GkVTyxEIKs1
   ZUCrzVT+i2tjzBl9yBC+d739aHrxe+aNdYNB06uvkzWcjmmQXbB0yATYW
   kfN3Hr/AqBSphFtgBVQjuFXS1IDoZMFVxxhTR2U2jpjzGvPzk6JrogZ2p
   TwrV7YT+3uuKbjh01LCpjXdtFunduIkp0iczvV+U0oSoT0AsfA9J1zSta
   U6QOqDq5c6iSpHoj1G7HywwPoXS4Uad525+LSG1YUsmgAqKrag+NopUlr
   A==;
X-CSE-ConnectionGUID: 9bdmndt3T5qU4drq1W8kaw==
X-CSE-MsgGUID: wNbbZgG6RNaHZ2OZ9RIVhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3751679"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3751679"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:16:43 -0800
X-CSE-ConnectionGUID: WnMy9s8fRuS3iWBWzpGvBw==
X-CSE-MsgGUID: f16LsWyCT760siavWNcctg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9785900"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 17 Nov 2026 01:16:40 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 808CA99; Tue, 17 Nov 2026 10:16:39 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 0/3] iio: adc: Provide mult_fract() and make use of it
Date: Tue, 17 Nov 2026 10:14:39 +0100
Message-ID: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a couple of IIO ADC driver the suggested new helper mult_fract()
may be used. So, provide it and update the straightforward users.

The helper has potential treewide, hence it's provided directly in math.h.

Andy Shevchenko (3):
  math.h: Add mult_fract() that takes struct __Txx_fract as argument
  iio: adc: ad4030: Switch to use mult_fract() helper
  iio: adc: ltc2378: Switch to use mult_fract() helper

 drivers/iio/adc/ad4030.c  | 13 ++++++-------
 drivers/iio/adc/ltc2378.c |  4 +++-
 include/linux/math.h      |  4 ++++
 3 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.50.1

