Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967373DB626;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966308; cv=none; b=oHFdPXhFZnMSumPgWhEQLN3exTAKxHia6GTHimLNql+eg/gn7ZyCq60YsTW02SrPizFvK8bnvAUCAHnnRy8O3ZJt8BrFiej5WlaeH7kqQFFbu085ilz1yOSjsR4W7g26nSJ+RFJtIkm6zlh20Bo6RG1esq8FAANpboYI5S/t+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966308; c=relaxed/simple;
	bh=lsNO2+RzQtpW8/cPFiBt8mezwI0CiJdsZYNT3rjRokM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QN5tBeis/DCnGjnnkjpomTRMzhAMNVsb584ob1afVSO7lVVynzw4UISxeFYGRhQD2ZTVTE4vtkD2nW/K+xqqO9LAFJcvRzcFBPD7GHQ6PlJAORHQsHXn6txWR57jkY8afKZplfsfAT0kGJwHCEswtcU+HCiB1/NjGggInNQk458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qG4EzuRD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG4EzuRD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F346C2BCB4;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966308;
	bh=lsNO2+RzQtpW8/cPFiBt8mezwI0CiJdsZYNT3rjRokM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qG4EzuRDlj/KOJIdvlFgB9jCVA48uizplMEV/LwzngwocJnFJO2QAYgremITBYRkp
	 3yPqAssko20EZw10KiicC6ImHkrbL9N9yc4IXqqdDtxMWAUvtmAwjn6kylkpi5jay+
	 z4eqfj6gdY+ONHRcaMGLQB0ItIXe2/pptpyRSEuVsedQYN0HwLFehoUk2rlgwzfLXu
	 nc833SCW0ZsfpXwxQgKOKx+kIQkAh1K7DHBZF0q9OqW4BkWbu1fq7v4cKj+dtVT/Ys
	 54AUAEGld1P9CnIgBAidU/pBRrSKMM+jQwPhGhW0EV9PutWseJEkBs5oO1UtyWwEm8
	 B9SREPmuLKosg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D974CD342F;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH v5 0/8] iio: light: si1133: driver cleanup
Date: Tue, 05 May 2026 09:31:25 +0200
Message-Id: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM2c+WkC/3XOTQ6CMBCG4auQrq3pTAuKK+9hXLRlRhrlJ1SJh
 nB3qysicflN8ryZSUQaAkVxyCYx0Bhi6No08k0mfG3bC8lQpS1QYaEM7mQMAFpLX5O/Pnppnfc
 57pWtWIuE+oE4PL/B0zntOsR7N7y+/RE+17+pESRIVJwzADlb+OOlseG29V0jPqkRl3y/4iiV3
 KVHwDgmJvzlesnLFdeJm6JkhKosFLlfbhZcqxU3ibPTVFaeDDhe8nme38TlfmFpAQAA
X-Change-ID: 20260427-si1133-checkup-abcc5280adf3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
 =?utf-8?q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, sashiko-bot <sashiko-bot@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777966306; l=2308;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=lsNO2+RzQtpW8/cPFiBt8mezwI0CiJdsZYNT3rjRokM=;
 b=1lMiAumW5TWDeh5R5kVKcog4ojYe/+5F4RmeF3UOMUYcd2r1t3/OwAuCmjQ+2B7znKXTHwwO9
 tE5dN24xiMMB4SUUW+n1h5AYzEn0GA9RXbGbRgfCG/8LOfyktchoQSL
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

This series deals with the cleanup and modernization of the Silicon
Labs SI1133 UV/Ambient light sensor.

What seemed like a simple checkpatch cleanup turned out to be more
complex, therefore I've ended up doing a patch series instead.

Changes include:
 - adding missing headers
 - removing unused macros
 - adding guard(mutex)() support
 - code style fixes
 - race condition fixes reported by Sashiko

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v5:
- PATCH 5: fix commit message
- Pick up Andy's Reviewed-by tag
- Link to v4: https://lore.kernel.org/r/20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com

Changes in v4:
- Changed logical ordering of patchset
- PATCH 1: fix typo in comment, edit commit message
- PATCH 2: edit commit message
- PATCH 3: edit commit message
- PATCH 5: remove irqreturn.h and add mod_devicetable.h
- Link to v3: https://lore.kernel.org/r/20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com

Changes in v3:
- PATCH 6: add local variable for timeout
- PATCH 7 & 8: fix potential race conditions as pointed out by Sashiko
- Link to v2: https://lore.kernel.org/r/20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com

Changes in v2:
- Change v2 to patch series
- PATCH 2: remove unused macros
- PATCH 3: add missing include headers
- PATCH 4: group generic <linux/*> headers
- PATCH 5: add guard(mutex)() support
- Link to v1: https://lore.kernel.org/r/20260427-si1133-checkup-v1-1-20f5f11eba6c@gmail.com

---
Joshua Crofts (8):
      iio: light: si1133: reset counter to prevent race condition
      iio: light: si1133: prevent race condition on timeout
      iio: light: si1133: remove unused macros
      iio: light: si1133: prefer complex macros enclosed in parenthesis
      iio: light: si1133: add missing include headers
      iio: light: si1133: group generic <linux/*> headers
      iio: light: si1133: add local variable for timeout
      iio: light: si1133: use guard(mutex)() macro

 drivers/iio/light/si1133.c | 69 +++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 28 deletions(-)
---
base-commit: d86db1905add39f905cf9f04252804b359914ed6
change-id: 20260427-si1133-checkup-abcc5280adf3

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


