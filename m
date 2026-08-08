Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DB383C99;
	Sat,  8 Aug 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208307; cv=none; b=NWiCrjgjQN9Yvx2kkb1fxlU2fI3Dxl/PqG4PwmRen7KXRyY0ePLGvkuvfbaNdVmvANVZcxZVKnliOJknRgO5XG/0dGSf6Xy6oG4qGPO5bEXLygz8iYNBhv43ciWq3iTP5PYmt2tDxWhLkMnI2+NfLUyDYNWoPAwCwvCRTcKUb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208307; c=relaxed/simple;
	bh=Md3IGD9Xm80hkMLNc996V9V5s2coVfbpVTtCctkt6Bs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hFRYC1FcpngW+v97CLSys1E8mOSgvOQtvr5TqBznTlHa5NwOrw56zJNGcK9o9iGk2890xryKC/JnFvMzDX1m8VmU+4YZAJWko+JzPWNAGBHpQpyTczYPa39T8Rf4LoKK15S/L6NLUoUseRmE7/HF0PoXMQ91jTfwqhbyNe9Dxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U29bKNOT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U29bKNOT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DFBCC2BCF4;
	Sat,  8 Aug 2026 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786208306;
	bh=Md3IGD9Xm80hkMLNc996V9V5s2coVfbpVTtCctkt6Bs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=U29bKNOT+2m2nDvcgCZUKvq+RdjoUQeTDcyFneiRZ9JWpGinPJgGN5cxboIVYe/yw
	 uPq2fMxiKu9JMbZZJb/OuahCYr0v167Lh44TnyWW2I6eoKgqcPGkoFqp5S/pCI1WEd
	 lKe4qzIcich2GvzslsJSlD0sIDAKiKDXqWX+eNkF4+9+uGXQAsaPxwZlCE8gyeWxq4
	 QyS7I0FaT/Hsth62YcA9Kh9jbqyPs2cufXDDweLbcjt+esY9u8BkE4Ek2K8EARrFe6
	 O0PUCpO755HrFJrJZagFRKrDZHs+n845UGMtSKern4PmrXnbTv83PXnGAsda1lopOB
	 u+fn9nB5e0eDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D7CC5AC67;
	Sat,  8 Aug 2026 16:58:26 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Subject: [PATCH v5 0/4] iio: accel: mma8452: use modern coding style and
 resource cleanup
Date: Sat, 08 Aug 2026 22:28:12 +0530
Message-Id: <20260808-15-apr-pm-iio-mma8452-v4-temp-v5-0-d177e93ce3f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRgd2oC/4WOQQ6CMBREr0K69ptSW4KuvIdhUcovfGNp0yLRE
 O5uwbh2NXnJ5M0sLGEkTOxSLCziTIn8mEEdCmYGPfYI1GVmgouKV7yEUoEOEYIDIg/O6VoqAbO
 ECV0A5JLL+qxbNCeWHSGipdfuvzVfTs/2jmbapFtjoDT5+N4PzHLr/bbEn62cHETVVZ21tTVKX
 Xun6XE03rFmXdcPfpp+cNwAAAA=
X-Change-ID: 20260601-15-apr-pm-iio-mma8452-v4-temp-e040489abec3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786208304; l=2244;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=Md3IGD9Xm80hkMLNc996V9V5s2coVfbpVTtCctkt6Bs=;
 b=W0aSnZevebmJb3aO/DDGTZWv8mM5fBSXzKW8C2JqKC8ykHTzFupFga8CDwtkkE3YfmAsDYVkP
 2hMJjbGkBh9BsglM0wM6PLd7il8xEpITVjbTeHzayy+vGm9xUUiYZ3z
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

Hi all,

This series contains a nuber of small fixes, cleanup and improvements
for the mma8452 accelerometer driver.

The changes modernize macro like mutex with guard(), bulk regulator,
IIO_DEV_ACQUIRE_DIRECT_MODE() and etc.

Changes in v5:
- Drop the PM runtime handling patch, as suitable hardware is not
  available to properly validate the PM state transitions.
- Apply reviewed tags.
- Rebase series onto the latest iio/testing branch.
- Link to v4: https://patch.msgid.link/20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com
Changes in v4:
- Part of the series already merged into the IIO tree; rebase the
  remaining patches onto the latest iio/testing branch.
- Link to v3: https://lore.kernel.org/all/20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com
Changes in v3:
- Following input from Andy and Jonathan added new changes as following
  0001: handle return value to have proper error propagation
  0002: use non-devm API to maintain resource management LIFO order
  0006: convert individual regulator using bulk regulator API
  0009: use IIO cleanup helper for DIRECT_MODE
- Address kernel coding stype specific review comment
- Reorder local struct device and dev_err_probe change
v2 series -> https://lore.kernel.org/all/20260422165643.2148195-1-sanjayembedded@gmail.com/
Changes in v2:
- 0005: address review comment from Andy and Geert
  and use DEFINE_RUNTIME_DEV_PM_OPS macro
- Added new cleanup channges in mma8452 driver

No functional behavior changes are intended.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Feedback and reviews are very welcome.

---
Sanjay Chitroda (4):
      iio: accel: mma8452: convert to bulk regulator usage
      iio: accel: mma8452: use local struct device
      iio: accel: mma8452: Use IIO cleanup helpers
      iio: accel: mma8452: use guard() to release mutexes

 drivers/iio/accel/mma8452.c | 145 +++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 91 deletions(-)
---
base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
change-id: 20260601-15-apr-pm-iio-mma8452-v4-temp-e040489abec3

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>


