Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012262;
	b=tSuzy1hrqj79AkLO8xrY+lxOMVBvSEXi2IiZAUM2nNvWt5MSBhfckAxOX0o4FyogJpiq
	 ltyTLfuTnsrSd13CbrjheZCsJv/FVnBVx1h1LRl1H1jpQYFw7j75GoPkVzsgqFsDGVXhh
	 gkFbw4osOnmBJ55C6Z0i0ZOSjJut31HRy1cmxot78yxKHHaufjYTFkq7+va6e2N5Q4Ajf
	 1xmUuDToYuySZaveWNvAUM9UeeKOhoqecREJ5xDRLsWenOlzDNEnPadDDfIEexpVdqH4m
	 mhRpzfSk7iCRM5JOIJVPNbGY1YkVVPAqo6Gojxm2yPQAhUYT01Sj7IMBexqsonvwpHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012262;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gd56Sd7/GJp1QZRYj78YWZNIrrTVthbU1qGc1em23wA=;
	b=f26I5uxW/SxbwdQ4JsQkka5fe3jj7DbGe5dUXxxVAJQiMp2sWcLpRNoETAVpImcr8/Ef
	 FvMVeSfHpOMx4zO97cdHPcSqkXT5I64BASB7J6u0wY0P0mPbQ7jBSnPTSgnhubOJLz3Vj
	 /0n0gCVSMhNvM0/EI+GeGi3I6pKo7pWGNuAl2OUR77PxqYA6w8S3ez60fODx6ameA3WL3
	 MQc88pBIhnl0706yFUgdrriJb91EquA+GHfeOL/8eMIknSZYKodc/fV5+GwvBSkuTUlLC
	 5Jfygp9VFiE640JhWWJ6u236aEGPKxkC9Q7X+/xU5eKddtkQnMnVg/WZY5XQU3EH7HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEGsx1G6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA5606A31A;
	Mon, 26 Oct 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEGsx1G6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793012262;
	b=15uK5GSDiP/Jw0AOgRyw6GzMLLjbIFT/kuVMn2ccFPb4GJNaEQ9qfnCKFnXju3ZajglB
	 jm2C4YN+wYsKJLhA6fgKzLfRuHLpAgJz6qHVN2VfDgMkrR3zcwxr/FpDd8wRSsQpJ/OQM
	 FMAXNvWPl0hGL9gbfd0KSTr1EFsSq/mfEgvh6xE3dYb9vB0rsY0+UpERmG4JZJBgvWkGA
	 QuAIW9puL913uwNOoP6V1kJVRWCqVhzfF2I8aiWovIlvgc0F9M0VYq+pcHGz5oE0YzoK+
	 22P/YSmeisRkcjeNBSdT0A9ldFO3IJ+nryjeAQ74vuAM08z4FFRJmCRkQnOjuzH7CUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793012262;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gd56Sd7/GJp1QZRYj78YWZNIrrTVthbU1qGc1em23wA=;
	b=EQnVQcGnsbdRB81gh4vUcOHabZ9Zq/p6rQMnXTOGle67kW5oAng90OuHhR1aJE1/zx30
	 xDbtEPCyJxMlk0/XX1p4rYyDr2O3CZZ3vGuGmwuS9m4LQazc5hsDn7LFJWmdBsIVvj6WY
	 rl3A0bYRPd8ZOq9iQAK1MKrhI5Kyo1c2994YHArOCPtCAMMk9p3IJePEUdjjsJBpR3Akc
	 Rm4XboxnbfNFOL5Rmt94Umpw8Mgx6bUR47+QZr1dFV2ESWA5oT+Pp+NJuASXpIhLshCLW
	 9umhbHFTZ+bWO1IjRCva9Klb67dI918NV1NE0CFXkPMWGZ+rNxe6JQWMU97AVjRgW8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B265F1F01825;
	Mon, 26 Oct 2026 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012262;
	bh=Gd56Sd7/GJp1QZRYj78YWZNIrrTVthbU1qGc1em23wA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=lEGsx1G6N2JAxEK86wQ5/+G58d1ZahVNKqvt7rXZNqT1M2USjL31opJjdMfgMBxgv
	 OT2hZFBPNMdB+6Nrirr+2LVRBadN72eXHCO6MHRbQGthGl2VZvi1U757ZzwdmQW9V+
	 n5cl+KPgOQsObao3z08NtHkcbEhfl99l6au+gMlLrlPelEvs/n2tENUvsbQCCqJSmG
	 xn6vnAlcecu4pkZIP+gT6bPuGFL7vhkghl/gE2612IrZ7o7o0LUIDbph9YgTxxVzLI
	 Pq89022oiknc3MdYl/05CqezaWy8ZY4kMTqb7aUvK38e46vFC6Pj6B6Ms7A2CsTsfZ
	 EOx/ETI9QARmw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 32F5344CC3;
	Mon, 26 Oct 2026 10:57:41 +0000 (UTC)
From: Andrea Amer via B4 Relay <devnull+and.amer.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 11:57:38 +0100
Subject: [PATCH v3] iio: afe: rescale: expose offset if rescaler or source
 has one
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
Message-Id: <20261026-iio-rescale-offset-v3-1-7cf6540111dc@gmail.com>
X-B4-Tracking: v=1; b=H4sIACEy32oC/33NwQ6CMAyA4VchOzvDOhjOk+9hPMzRQRNgZiOLh
 vDuDk4cjOnpb9KvC4sYCCO7FgsLmCiSn3LIU8Fsb6YOObW5GZSgRCmAE3keMFozIPfORZx5JaC
 ujJRP1SqWD18BHb139P7I3VOcffjsP5LYtn+5JHieCltR60Y7B7duNDScrR/ZxiU4EuonAZkow
 V6g1qoRUh+JdV2/kbOZ/PcAAAA=
X-Change-ID: 20261012-iio-rescale-offset-41254a33b6d6
To: Peter Rosin <peda@lysator.liu.se>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Andrea Amer <and.amer@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793012260; l=1684;
 i=and.amer@gmail.com; s=20261012; h=from:subject:message-id;
 bh=7+5E3nPFEdzUpCLuOKaAoA53dGKvrkfb4WX9YIOvEws=;
 b=VDVUdoBQYQZjXbvlRrnjs9xQP1nPAFe0JmJx9Tt2pyo1JnTRYUYHBNNdwsLcBoThKUmDJOkI+
 LeUx+i9zr0pBbYdo5hBBJ0UiHzzisYggm3mVKvnJ68WPXD1vwwYeTyl
X-Developer-Key: i=and.amer@gmail.com; a=ed25519;
 pk=TiMK202FvcPM+yKGkAI4hsAZA7QkwyEgru97PAFa4pg=
X-Endpoint-Received: by B4 Relay for and.amer@gmail.com/20261012 with
 auth_id=1165
X-Original-From: Andrea Amer <and.amer@gmail.com>
Reply-To: and.amer@gmail.com
Content-Transfer-Encoding: 7bit

From: Andrea Amer <and.amer@gmail.com>

A rescale channel advertises IIO_CHAN_INFO_OFFSET only when its own
offset is non-zero. A child rescale therefore hides a source offset,
and consumers apply raw * scale and drop it, even though
rescale_read_raw() folds the source offset in.

Expose the attribute when either the rescaler or the source channel
provides an offset.

Fixes: a29c3283653b ("iio: afe: rescale: add offset support")
Signed-off-by: Andrea Amer <and.amer@gmail.com>
---
Changes in v3:
- Only expose offset if the rescaler or the source has one (Jonathan Cameron)
- Link to v2: https://lore.kernel.org/r/20261016-iio-rescale-offset-v2-1-02c825967139@gmail.com

Changes in v2:
- Keep the IIO_CHAN_INFO_SCALE line unchanged (Andy Shevchenko)
- Link to v1: https://lore.kernel.org/r/20261012-iio-rescale-offset-v1-1-14ed15979ff2@gmail.com
---
 drivers/iio/afe/iio-rescale.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 3a6a09ffa5267ddfd5131fbd04a5df928836589d..c01292a15a29d02afa8de80a778c2c2a2aeecd3f 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -303,7 +303,8 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
-	if (rescale->offset)
+	if (rescale->offset ||
+	    iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))
 		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
 
 	/*

---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261012-iio-rescale-offset-41254a33b6d6

Best regards,
-- 
Andrea Amer <and.amer@gmail.com>


