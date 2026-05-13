Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810135E921;
	Wed, 13 May 2026 05:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648452; cv=none; b=I6W3iKvViR/KL+SPPq1t/AB6TebLnQCrDawlM4PRn0sNLFSV/5QNt7LP+YeLHISf1tccSBmuud1e068kzqRXLf5S0P7gxNDtrtXtkWCjFNmA71svwDMYAKsfK4u3b99XlQcMKOEvBTDDGbunLDZz6Tb3LNw6qd1LkNkCZzw4kdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648452; c=relaxed/simple;
	bh=XH+azKLywEpqSB0i4Y2/0GdjxWHJ3jmNGYIdBfCkokk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f0mlpR9aZQaIdkKumaKw4z+Ewzddx0c6SSd2W9LgF7W3JOb5FrfFEFj+0J2gICuL81mEor5y49vfCS5R3KQslvtkcmy+HVCkFmvi6tMXpMXXl7NLe3scoEXw4TAbqYvYEExrLn+m8JdBbyTC+Wa0jQKQErVrYqEH2uiZbDnZCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=EWzUj4tu; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="EWzUj4tu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wmRv0NXfvAce8J6idgvVoBoDVEkEvCPS+byXzjlhfXY=; b=EWzUj4tu2qzfPmKhV0LSyUP0e/
	A3Cz/uHu48L9IkjANb/a1YpjHBFiqAv3m96wTSFuqYWuSYhq66rTktXoZNmFXhYgN+SZ4xLsE9A4C
	FjHk6I/Of960hPJwD4wgsKFjbs6KWEqYQ27n2nLNvt82CpPG3Zr2fSCWOIHPd3IFKaO/f0TOsHCTA
	wHenwyyZu3VIEVyvd4fTF0N/XL2DjWhT07Tem9YpjMwbSj9QswWL7yNHGUYgDPV0Ekmdr0Nq/dJvz
	tXMo6Qyxm0FeqhwFcpFiVFhp6DPag+9/FW6S6wF+n0enRdIuxJQM3ZnwtG5vQLHaz1NdAMukZmbCI
	FV+w8Hkw==;
Received: from [91.102.182.218] (helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wN1i8-0000000EWci-1TeL;
	Wed, 13 May 2026 07:00:44 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Subject: [PATCH v2 0/3] Add GPADC support for A523
Date: Wed, 13 May 2026 06:59:41 +0200
Message-Id: <20260513-sunxi-a523-gpadc-v2-0-d5efde151dac@mmpsystems.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD0FBGoC/2WNQQ6CMBBFr0Jmbc20UlBX3sOwKNDCGIGmAwRCu
 LuA7ly+5P33F2AbyDLcowWCHYmpazdQpwiK2rSVFVRuDApVghpTwUM7kTBaXUTlTVkIeU1vxuj
 SpTqGbeaDdTQdyWf2ZR7yly36vbMbNXHfhfn4HOXu/fIS//OjFChil+ToYkR0+aNpPM/c24bP/
 g3Zuq4feLPNdMYAAAA=
X-Change-ID: 20260507-sunxi-a523-gpadc-1879aa5df754
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maksim Kiselev <bigunclemax@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Michal Piekos <michal.piekos@mmpsystems.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778648397; l=2048;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=XH+azKLywEpqSB0i4Y2/0GdjxWHJ3jmNGYIdBfCkokk=;
 b=5J2hVbVK/PUi9ynrfmAOgLftmF+fQ6SsWektq2wfCiUiElGmoG5SEivGpI8stoM35+fRw6Csl
 1XMEhEroFq2BRVkNZsXI0sEmqTDmEPTSV9GjBfystqCGyBjfXXJn8NT
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

Add support for Allwinner A523 GPADC in sun20i gpadc driver and describe
corresponding node in dts for A523 SoC.

A523 uses same model as existing driver except it has two clocks.

Added support to enable more than one clock in the driver, extended the
binding with new compatible and wired up dts node for A523 as its own
fallback compatible.

Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
Changes in v2:
- Handle scenario when 0 clocks has been defined
- Fix copy&paste sentence in 3rd patch commit message
- Moved status as last property in dts node
- Make A523 its own fallback compatible
- Removed redundant maxItems/minItems properties from binding
- Link to v1: https://patch.msgid.link/20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

---
Michal Piekos (3):
      dt-bindings: iio: adc: Add GPADC for Allwinner A523
      iio: adc: sun20i-gpadc: add A523 gpadc support
      arm64: dts: allwinner: a523: add gpadc node

 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         | 32 +++++++++++++++++++++-
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi     | 11 ++++++++
 drivers/iio/adc/sun20i-gpadc-iio.c                 | 11 +++++---
 3 files changed, 49 insertions(+), 5 deletions(-)
---
base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
change-id: 20260507-sunxi-a523-gpadc-1879aa5df754

Best regards,
--  
Michal Piekos <michal.piekos@mmpsystems.pl>

