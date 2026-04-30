Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D12D1F44;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561517; cv=none; b=DmlcD/+R+uPrTkJE5KkwPorIrIpXyTWP1dASA8dHXuK1PlkmEXkazgd9jtPJQHSybYjFHlBxsHET1hx0zkD9QtSh2hajGA6kqsNprnvzV4emw+ar2vfw10jImqTtxo49QHGU8RQBLNItwjuB4ufZ1Wn/8ZPQWeSBB2bsubu0/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561517; c=relaxed/simple;
	bh=wxvavDItxIdXI5SuqvNOyJKstYPCL/SPeYi92G8Ci/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UHZXgxg6cJyO3/JDOvPWysx58/rMtk8B7NBJmbFSbpL4/u5OB4oeGkel+22tPnVtnqHJmX2ZMeWULDFL1KAQ0UIq6QJ2tp3v8IJwamtdBo5Z2uj2KYnExX+4qG38Eg9vaq3yUM4UtKa03ifPnemZxShls4sh1wK08ZeFxHrh9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFSgIDGI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFSgIDGI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DF1EC2BCB3;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561516;
	bh=wxvavDItxIdXI5SuqvNOyJKstYPCL/SPeYi92G8Ci/Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qFSgIDGI17ZLo4SAblVNvO92Diz6l/tiw0vgeE0U305bhOlxu+kuidp+OQFFouQ8o
	 M/0PVMzmKsHI/de8SXdmalCeRIlE9AZUflMvYDL54I8EBPrkNO9eFDjX4aKOyGEkqh
	 WBL5HOXQ8pmxKVDId9QSNQrx5HMrUMbYugQRDqrNNvwBxXwgfQslm0Ayd0ep5miTvg
	 xfi5Fe97/9fZwkG3aU94wPDw9wdoDH4/OZ+anTO2J3ypBp5EkinrQHH+Qyk1ZgvUWE
	 YRMjDCDGT6YfajWRbnqWMEKgTAAuhAJjae7hFbn7bXz675FZi/AoE6HCl6op0IQcA+
	 hmOuwLfi9xUgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAF4CD13D3;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH v4 0/8] iio: light: si1133: driver cleanup
Date: Thu, 30 Apr 2026 17:04:20 +0200
Message-Id: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRv82kC/3XOTQ6CMBCG4auQrq3pTMufK+9hXLRlCo0KhCrRE
 O5uYUUkLr9JnjczsUCDp8BOycQGGn3wXRuHOiTMNrqtifsqboYCM6Ew58EDSMltQ/b26rk21qZ
 YCF05ySLqB3L+vQYv17gbH57d8Fn7IyzXv6kROHAULnUAZHRmz/VD+/vRdg+2pEbc8mLHkQuex
 0dAGUeO8JfLLS93XEaustIhVGUmyGz5PM9fSJFXWSoBAAA=
X-Change-ID: 20260427-si1133-checkup-abcc5280adf3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 sashiko-bot <sashiko-bot@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777561514; l=2132;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=wxvavDItxIdXI5SuqvNOyJKstYPCL/SPeYi92G8Ci/Y=;
 b=prebCTS+DeZQ0Wdw7mqtAiFb4DCEkslIlyLoTgUZdrg8uxQhEKyBF33RMkfGVvGQlwq+qMKUN
 La0kW2MEfEVD/sgq2Pb1fe8E1r9mUsu8ZN0rCyfE1TATnmzdgny4v9t
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


