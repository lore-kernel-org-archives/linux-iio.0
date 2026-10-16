Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE940BCB2;
	Fri, 16 Oct 2026 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148441; cv=none; b=g29EdMtiOw06P1ru+shu8chUFmxIgP+eJN32nY6EyngW5GLPj4Zgh/D/5J5/ITAzWveGQhBZ6K8GjIoBrmXpGtKxbUwiXJdOe9NbkGMaVeehaiDjrezzOMKirI9VCa7eZ1vVwrQxbf/nBA5W3GLq7UhUN34P1mujwvXHtl53cRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148441; c=relaxed/simple;
	bh=A5vzqO97WgNgrRSuAFaMNoJdjRf2NsEvaKC2UjsFRLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KAo7F6fxfyxGuymAorxZqlHWpESHeRSe9ZunRZG/LeHH4kPCi6CffS77bPjG10AV3E3BM8C77z7z+YX6Gn5/hTDdwvVckxIZysmuy90jT/NkwfLsZoiIL9jWh5AFX5s4gdFkEwBbH9qW4iMhs1wgEW97SVwN5YIO+k6HKQ+1BCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSrDood8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSrDood8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2CDAC2BCFA;
	Fri, 16 Oct 2026 11:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792148440;
	bh=A5vzqO97WgNgrRSuAFaMNoJdjRf2NsEvaKC2UjsFRLM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=lSrDood8FrYKE2qrBZPbVIIwBUuTmfY80LHxX3LLFDwxBFXrbBE4XfXQqFarySAjK
	 xlrPwYIzuthTl3EONWqLvvS07shSYasN1Zhf8XXL7Dd84eqQZ2CsTgeKnLDy2yQpvD
	 wIWqm/7Kl2FjBnNFUI0aGW+5mHzeN8JeBV1nIBgcCRpY3tZrWmwFXdI7eI+PxdAza0
	 +dMZwF2s2bLywpnbvmrPPh3+JVZMGVFHKc4Sb32+Ktm+q5j2Lrm0PVvikT4IDuuBs3
	 r7UNwk7pzej2pQQzsrJcawyNpBmfFISRM/K1cmv8vVRHe69mY58iFi8aY3p0ZwGLNh
	 rn79NkkHEn+2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0494CCA464;
	Fri, 16 Oct 2026 11:00:40 +0000 (UTC)
From: Andrea Amer via B4 Relay <devnull+and.amer.gmail.com@kernel.org>
Date: Fri, 16 Oct 2026 13:00:20 +0200
Subject: [PATCH v2] iio: afe: rescale: always expose offset
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-iio-rescale-offset-v2-1-02c825967139@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMMD0moC/32NQQqDMBBFryKzbooTY4pd9R7FRZpMdECNJCItk
 rs39QDlr96H//4BiSJTgnt1QKSdE4elgLxUYEezDCTYFQZZS401SsEcRKRkzUQieJ9oEwplq0z
 TvLTTUIZrJM/vU/rsC4+cthA/58eOv/avbkdRoshh29067+VjmA1PVxtm6HPOX08tp+S0AAAA
X-Change-ID: 20261012-iio-rescale-offset-41254a33b6d6
To: Peter Rosin <peda@lysator.liu.se>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Andrea Amer <and.amer@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792148437; l=1534;
 i=and.amer@gmail.com; s=20261012; h=from:subject:message-id;
 bh=smDOZf3s0TRH8qOItOidEFI5I1QOKi3ZjzCMwcFZDI8=;
 b=UR/i6E6rwteZ0Erdlwc7kK0TfnZAzzWBdHcBVSiQNaCkKvutisIOPQoqdlDbpXTGqKVvuXrua
 8hVFvwQCq4KCzhsirlUCUM73+FI3tMml7m9wjmB4yKv3FiF/pmCQ/7Z
X-Developer-Key: i=and.amer@gmail.com; a=ed25519;
 pk=TiMK202FvcPM+yKGkAI4hsAZA7QkwyEgru97PAFa4pg=
X-Endpoint-Received: by B4 Relay for and.amer@gmail.com/20261012 with
 auth_id=1165
X-Original-From: Andrea Amer <and.amer@gmail.com>
Reply-To: and.amer@gmail.com

From: Andrea Amer <and.amer@gmail.com>

A rescale channel advertises IIO_CHAN_INFO_OFFSET only when its own
offset is non-zero. A child rescale therefore hides a source offset,
and consumers apply raw * scale and drop it. rescale_read_raw() already
folds the source offset in, so expose the attribute in every case.

Fixes: a29c3283653b ("iio: afe: rescale: add offset support")
Signed-off-by: Andrea Amer <and.amer@gmail.com>
---
Changes in v2:
- Keep the IIO_CHAN_INFO_SCALE line unchanged (Andy Shevchenko)
- Link to v1: https://lore.kernel.org/r/20261012-iio-rescale-offset-v1-1-14ed15979ff2@gmail.com
---
 drivers/iio/afe/iio-rescale.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 3a6a09ffa5267ddfd5131fbd04a5df928836589d..4639a67ea462bf5c29603783a6f230d769fb02b0 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -301,11 +301,9 @@ static int rescale_configure_channel(struct device *dev,
 	}
 
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
-	if (rescale->offset)
-		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
-
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot

---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261012-iio-rescale-offset-41254a33b6d6

Best regards,
-- 
Andrea Amer <and.amer@gmail.com>


