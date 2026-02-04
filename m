Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AFD421EF2;
	Wed,  4 Feb 2026 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228485; cv=none; b=FQtbUOndcu+fAgTtZ8b9PNjLY2IXhC6vkQS/EgEVuBdHIcfGipugQCQnWVDvgd9VYW2BQzPpzZZEU3bFWEqWYFdbgeah7IPIpjGV+4TMNByfJ+KD0hKWqZ4IJkkGaNE+JL/5FagrwjB+dD+ew/t1hB/yWM1P7Y/FvMm1etKNXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228485; c=relaxed/simple;
	bh=yFIbO7FxEvT8QpPFsZUIbJAJ77HARMB8TeJArhgVyeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZxUj8W7UcDxTbMLln3Z2L1HSv7AkWS5BlAQFUnaBVS/kyKlDUGFQrF9k2cOJBh7k4pd0oVPLSWsnQ+AQhpuwNheJuSFBjid1St2zWMxKtk4Upq009wHJxaEDxtV+x1nN/8t099ZOf6/PPvquQA201W2TJsLntgySOrAhbDuGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: l9Ux9FX9TIaCLBhH7rIFJQ==
X-CSE-MsgGUID: BWkzjjASQ+is0Dcu29fxsQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2026 03:02:55 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.27])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 153EC4054E63;
	Thu,  5 Feb 2026 03:02:52 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH] iio: ABI: fix current_trigger description
Date: Wed,  4 Feb 2026 20:02:02 +0200
Message-ID: <20260204180202.515393-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Triggers exist under /sys/bus/iio/devices/, not under /sys/class/iio.
/sys/class/iio does not even exist. Use the current path.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5f87dcee78f7..4fc9f6bd4281 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1428,7 +1428,7 @@ KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		The name of the trigger source being used, as per string given
-		in /sys/class/iio/triggerY/name.
+		in /sys/bus/iio/devices/triggerY/name.
 
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY/length
 KernelVersion:	5.11
-- 
2.52.0

