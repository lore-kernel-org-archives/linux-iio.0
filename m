Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A9346E7E
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 04:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065475; cv=none; b=uuBPOuvjQVGT8MKy3eFtQLtxvpFggKKKWat71pb98s94JiFombK0WmjVRZ0nfHkUtwMZzFvQDY1/lkAypbWArBnyJynunpjJ0x11yk5/Yp2voCh/8Off6YJ+Uu6aWb2KnpQ4GBxy7viN1IFCCPksexluMmL+XzeOr212X5BEXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065475; c=relaxed/simple;
	bh=+Tmu7i8yM7F0GRGODToGeO9np0mQHettFpJQNZpLf8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cXrV70NTEhxu0bRYLwrAhU9qrIXKb7/nsyMT8ISG9EOuWidNpjA9hMR6RXPT96f3ogqsxTyg8UgK3T44/tMLHOiWKQMBQplJgPQzNx3Av759rY+9/3JoCjazDhpphK3E3MFx3ipY4kIxBIg83/ro2PYwpIf2nti+Jv6kJALoyqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyBwd05t; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyBwd05t"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-304d7f31215so5606928eec.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 21:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781065473; x=1781670273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nhyD2X+RxLYsqiZZ/asqiLK7X7/Tmw2xZEq1tX8ijhc=;
        b=PyBwd05tP0Xud0PO+ehqnu189PTMj8Hm+/oG5f14XTFTbJY0U04OqXoPhF1Avedf40
         5cnIpQi/gdQuso48Rc6jdZxUyROMPdsh7/z9rG0dsV+1GVwwZ1AbCyFkDbbk+1twiYoM
         gaSP59sFbVc+ccw8CVkhwEyDyBC1T3MrvOvch/v6auhSMrb9IO7jCRB/gj6Ev1c5UGrD
         ynzfHbSMKiSZsSBWFP2bDEZgAbPK6WrKATggTo3mZrvRlR39iB1L2xiuvaAEw9X/0YJh
         5QFxpMHqCEsHTWeMp3guPkawBkntnNqp/4Zn6vixMGeh6SeCo4nkdyU7agNt311XWpP9
         RMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781065473; x=1781670273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhyD2X+RxLYsqiZZ/asqiLK7X7/Tmw2xZEq1tX8ijhc=;
        b=Z9/RLU57uNzQtxy3VXoi5M18bJK7oxFbvFMXH83cSec3iaqrbIYhqoS6bKCDZSKXPk
         bBnL7K9Z57RF4uNtN2hNKX4G/twZZehU2Sjgf+J89DkBuAyswhX+lj4SNv4P0Fj3rYnz
         VC1rB25Umy+UKyNSV+3RWfEswVsHdzMSxXO353rqHvaiJb76BrlsK5x1oueyJYWlWQFF
         gLQCWyjJZuiwEHx2t7w1jMqEw7pRfx/1trOYlwuGTC6n/0w1WxIjhRic4TXay+JNSaHe
         cT33aSmT8cj5TCY+TdV15qQakTrnooF/Mkcx2s+AOWHC1qUNn/Sdc9aJFxYh6FggzhYH
         nTsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vSHYg/h8+XLWqRwjJ4bHz5jb36tbAfI9rZ4rQXX2RtN4hRnJw3KlvWhgc0xgJqJW2M2QuL6ZMKdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/tgIxbrN64YKO4phrkrouu+NGIWN/OK4+JfoUqB+VDzt3anW
	0x1dcZuFZcetxUhK79iNg9icksudl+zEydxre+HRVfxukdg5HJaWkf49R6YUHfds
X-Gm-Gg: Acq92OGlVkMuhGfqjU6UgPB6krdctr6Lkl01NLFTWg8mwz1fFLQscoocIUmXGXpowbG
	05ckUzZGpllPku8l40TTQE3aTR6suV+wfkRrxmCxzGO8LjrJWqSCTbqe9to/MCI9G8Wq2E6sScQ
	xO1aQ1wpiktP3pt9Gv6ihDJcvYS4F+fvjtSMrbOFqGOvHefBEm2Q4inpYN9DE+b8VSy7ZhLgHRA
	cDYmKjHPQp1EW1Dyy/z8pOBqRoF5sKfGada+N5A4OZMVFXetkHo4Ge2Xottj5VufJ6bcON6UxE8
	pcAg7SYLnplV1Vzdf/g+GGRTTwTvCPGYx2/GabSG08nmFMweI5J/dMUPRHT+Na/StX20WPAoyDJ
	g2BBQxC+96As9XepgUwHfqS2psxZOqk30nQOKG7ID11BDVK8jzoM8HpoA2zlKomfEEsyg/WlC1v
	HLgMFJJk4fjLTWY2M01ksHKpNEpP1jejOchAPzQnpiHWN9qndLmHmvcGh2r3INqWlZQjiEuL6X+
	Zww
X-Received: by 2002:a05:7300:d70d:b0:304:c520:4e14 with SMTP id 5a478bee46e88-3077b32888bmr16146167eec.11.1781065473096;
        Tue, 09 Jun 2026 21:24:33 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1381495bb00sm10941619c88.3.2026.06.09.21.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:24:32 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v4 0/2] iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers
Date: Wed, 10 Jun 2026 04:24:16 +0000
Message-Id: <20260610042418.90308-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded bitfield operations with FIELD_PREP() and
FIELD_GET() helpers where appropriate.

Also simplify bmc150_magn_set_odr() by returning directly from
the matching table entry.

v4:
 - Split include sorting into a separate prerequisite patch
 - Remove the extra blank line in bmc150_magn_get_odr()

v3:
 - Add missing include <linux/bitfield.h>

v2:
 - Use FIELD_PREP() and FIELD_GET() helpers as suggested by
   Jonathan Cameron
 - Simplify bmc150_magn_set_odr() by returning directly from
   the matching table entry

Hungyu Lin (2):
  iio: magnetometer: bmc150: sort includes
  iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers

 drivers/iio/magnetometer/bmc150_magn.c | 50 +++++++++++++-------------
 1 file changed, 24 insertions(+), 26 deletions(-)

-- 
2.34.1

