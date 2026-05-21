Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72315396D2E;
	Thu, 21 May 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357343; cv=none; b=mm+we4k/rdVyYqosDGdLrnBII9Xb/5k5wXAvxsoCn81u42Hnh2UjCi57c4PnomXomSeTkrnUZ04rxqhZnffYCqN7AbGK0pRa4DTDGAdv/KDzBTjPt1O7wgutpjeEPdPibD+v1XapgRvrRxfCKEldmHoEyQCpbP2shaoxPb9/lHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357343; c=relaxed/simple;
	bh=0cZpIBG05oVG4VLhk+isfCPecoEYvj0aQBsmF1kKbDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IsPRIDIXgv0BehKWsrvxkbMEirGrpoNVA3PyzvFmV73RlOPFKQE5+1mw5pR0Y9iUnGjjZ3k7O3YhiMlK+irG7pqbM13RsPciN6pod8MvDHc1Q+RbOf942132zg9JfAZjiofqKuBj9/IE8f44567RfdPNutakLsvg38i9gGqy58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u88/EUvN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u88/EUvN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55EA1C2BCB4;
	Thu, 21 May 2026 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779357343;
	bh=0cZpIBG05oVG4VLhk+isfCPecoEYvj0aQBsmF1kKbDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u88/EUvNIxo3FpPBopnJ3D2OeRWS+7MdIzxIKKNkLuIrlJLlNi6a8C5x+pFfAktCr
	 c9MHkjSsoUe2UbuR591/4yTywkLU5IOezkf277PlMd9/31LFOSvf3BrDHark9Cw6eU
	 qewOxeRB6+dYaXSDlgeBmIgDeUWlvKLZAz1aLaQgqqOZ2azp7bC1v7Y4x+hn11IBCO
	 EcPRRR2lXzT/k4B2gZdZ65yOs4R2vTicFO61MTS2uVRKAZAE6hh5uXYY4x7i7wbXgv
	 iYFOINE0kf9Y2PKI/zgjF3jwNNBwtc2MN0sCVVemJ6iXOSLHcTT+/3q1d7fIhy2ylV
	 bzKeOwZmQRyMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F776CD4F5E;
	Thu, 21 May 2026 09:55:43 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 21 May 2026 11:55:44 +0200
Subject: [PATCH v3 7/7] iio: light: opt3001: add comment to mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-opt3001-cleanup-v3-7-820169dec8c3@gmail.com>
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
In-Reply-To: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779357341; l=747;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=nPTHkMaVXMtfkGG3J9CutOPKt6djL0Q5K/PInamunpM=;
 b=tfZGJJQKv3e9OGXO8HACxP4MwXKSKOIZBIbPGD6yW/Wm2XKsmfVdV6Yy1sW/OvStrWEkhWzA8
 MzBFt738c76DYYrIpEVgNQTtKBsw6k21iOAPQ0iyk5EJIzVhj9eeUAS
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add comment to mutex per checkpatch.pl report.

No functional change.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index ac1c7ba5679867f6b814894680e317615f2e373b..9d24d7a23ef00d160fdae737b6ea1943576a3fcf 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -103,6 +103,7 @@ struct opt3001_chip_info {
 struct opt3001 {
 	struct i2c_client	*client;
 
+	/* Mutex for ensuring one executed command at a time */
 	struct mutex		lock;
 	bool			ok_to_ignore_lock;
 	bool			result_ready;

-- 
2.47.3


