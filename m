Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938206;
	b=I8bS8UHs+IHjETn9FzL8EK5MqwlkkqwcLhJKj2NP8eNP8MDBQRaWW24sgRASmxe9aOsa
	 Ci7I39nIO3UmAtXQyK6T/gqaRZBNXxbnvTDFRL03ZkbOxECc1z7APTCcLOXL/PhNkriXS
	 TdUwfzN6YgxF1dDqDgG9u2VyyVB8pG7KWbh7aAP3l9kSigMHRf/yaoxHGgH+WixJudHIF
	 vlZNTNPUFlMICXdknO0+YYFhjiWbu7XEPU5qaoKz6K8qXY8vGNl1DvMxAkYtMWG5H8JZ7
	 a6lPEJ2JexziUUhZ2+9ZGNqGl4wmBxpYSMpSoGp4JM+T0swU/LpoTefi1fRmIvLHgEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938206;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=C40fiRCk9L71R/bApiGXNANtJYBkFW0sGqUATJahP2I=;
	b=KfmDbnxLAViLjvkRyJVrsNsHhn2jNOcsPCvAd0xfW8W5au5t72F6sh7niJZW5vm4hIfg
	 +/IO2R06QS9W73XQeEK9u6PATwuLZslCqV5iw86s5Ag4hfBXWW/HED6EMqZS/EPhCExvy
	 rRQIWu6dlq/t8lUeV1uuxhhvtQFN1B1rCWRoiz64t6mQtuHfjyYY4FfQGw7lGqZUr69ip
	 xS+E/naMS+TZOiE3+FHE4WD8R+Iu8ExsRG7iWWjbvPjRsCvdb5FoT8IxabpQrb2J7+v5c
	 rn2jr20HUYXtyIOjl0oH3j6t6UbpWVAzAdTWB7K45JrwA/rOH2haIPbm8LmKOwyBZIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQG6pzzm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B2606A31C;
	Tue, 17 Nov 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQG6pzzm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938205;
	b=aWYx0xNZqNAaqw7Dzw/UUivJQBVbDQfxXrDmPBoDEh0FLJtjLiAgsJfJRKU0WvZNy9PH
	 0jLHGuTC63HqWc8eekyKrLD5lBTRJej41ak34A8OsosG0Liw09AoXv5GR8884j9XegVxE
	 EYA43BXAqL5jHKuf0D2uMtFhH1EJRZlv7h+/tcgzfmbv4mQbsZ5SBK3ZEgUK1UBM5+YfP
	 0QRIst6nKMPu6Y3VGBBNZdT4jf00asD8lJqoaG92HPhvvThcaNd9ms1Ju2Xs7Kxz0xlc6
	 xQaasfcndN++6qcocJt8pK3FMhmlL3TRrFbf8IDuKh9bwhqH+ItsceOkeszKwGtn2xA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938205;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=C40fiRCk9L71R/bApiGXNANtJYBkFW0sGqUATJahP2I=;
	b=tlRS/NFZTVsZYPjd3/94S/5qEqOa/1mYKFx9dnvEg6+BnPE5Z50LwvF8oF7Y1cv5R/GU
	 HM2kpU6HXw58RglchD2mMlOMc+LqpXtCMXSxNhnc18Qj29h+wYKopOGulvmVTc9cqjqpC
	 LGH8KN+XRzANni3bytiDAzXfsIb5nIOybVZ0Ca7gwDaOM0i/iHearSNOSEanQYCDivWnU
	 VAwUoVsKVCheLAonMpfa/wN2iKxMrGi7b1Jya8523kF5K3teaKqXU7AR5pECfd7serLPY
	 1ZLcVd3girC9kflfE+OrlQvScNnzyvdMqyTW9eXX8sQSlpS3US9TwB3ofLbejyee/MQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 479811F000C7;
	Tue, 17 Nov 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938205;
	bh=C40fiRCk9L71R/bApiGXNANtJYBkFW0sGqUATJahP2I=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=LQG6pzzmKLChzL8WIgMYahsCt06zWqgvfvcrOnFYRB777NSNYFHyLZNVWyuD68bw3
	 oq4wGwSdj/Hl7MBNbAjNeZpjYLFmxK0f8QOjIESa2M9RuOlZ/R/Dj68wPk826GvAuI
	 f/QP/UCVat2iqRoidhHcIkP3JykdDJF96fUgkaj7BLtfUcpQCh8PdNDb6tWrXv3dw+
	 bNABVnzbOlua94/mXlzxZ6MaTaKzQvv9i1n+8zKB8ABZuInTIy5U6OTh2WukBJtqlg
	 vsrQ2CzAujPFeslklgpZ6WUp76lBrOGj/vUFQ6ctsuSl5qToraZJfKfD8GprboB1RT
	 ceUJ0uQLT+7tg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8E13F4AA28;
	Tue, 17 Nov 2026 17:56:44 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v2 0/3] iio: adc: mt6359-auxadc: various fixes
Date: Tue, 17 Nov 2026 19:56:31 +0200
Message-Id: <20261117-6768-6358-fixes-v2-0-1ffc3c2f3c80@protonmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4X07Bq2DaV64j8Mh1IWWSOUtEg0h
 H+34Nnjy8ybWUWkwBTFNVtFoIUj+zGBPGXC9Xa8E3CbWMhcasRcgS61Aa0KAx2/KULnWldebGc
 JUSRrCnQESbrVP46v5kFu3mf2Rs9x9uFzXC649/6vLwg5SGu0sUphIZtqCn7242D5eXZ+EPW2b
 V8x5aBZxQAAAA==
X-Change-ID: 20261103-6768-6358-fixes-fcdc79afae11
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938202; l=1125;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=bnuhqaQ0sDql99jd/NNF2dGROwPEVF0Qts64YTX5a1c=;
 b=JPZx9Vw82WzozSKA++qp1LgaxtkvhMc/qkvoitXKXucEkCFXc38/VDZfO+PSBBS0T1oTuWQIL
 anX3euNZ+/pA07fDikoSFIV9mNH2RTxNOdjQaDrnhj+/gVlOO5Mf+vo
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This patch series fixes various bugs in the mt6359 auxadc driver. For
some reason, the driver had channel types for temperature or resistance,
while the ADC can report only voltage. There were also issues with
battery channel ready bit masking and scale calculation.

Changes were verified on the mt6358 (mt6768 platform). Compile-tested
only for others.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Changes in v2:
- Clarify bit number in the patch 2 commit message (Jonathan)
- Link to v1: https://patch.msgid.link/20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com

---
Roman Vivchar (3):
      iio: adc: mt6359-auxadc: correct channel types to IIO_VOLTAGE
      iio: adc: mt6359-auxadc: mask conversion ready bit in mt6358_read_imp
      iio: adc: mt6359-auxadc: fix scale calculation

 drivers/iio/adc/mt6359-auxadc.c | 88 ++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 46 deletions(-)
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261103-6768-6358-fixes-fcdc79afae11

Best regards,
--  
rva3 <rva333@protonmail.com>


