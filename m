Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420288;
	b=fCPNnpPTdVVoCjNP7lEf8YkLKSqKH7RyXYYS3orhq0exmYra2imP28qPocYiz4q+Ycpr
	 TSM4dQ82QfQn4u951YWJLh3vfGfyiKQFtASYNzSC+TFP6BhI4Zz19AStsm+v1qlwopMfl
	 OXfyASvCdvPz7MgZZ/C/qqPJruYZopar/oKHln9c3e8EXLfAGL+c+tv2xM1i/yZYCPUdn
	 0z3tQYQTJ4GGbuw7Zwv5HsSebECswiom7cee6MxIrgd3yaRwm0dpiTmjqMbo1klk//CqM
	 xpfC6+BYV0+Q55mj5uPZuMsphpqFA62f3MSPMmyoNHw8SdP8ZUHx3N6UKyuILuVRijA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420288;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZHQEKf1KqLu6uI/mLLyIWsaJG4xlK8Pi3bGb30llIjQ=;
	b=crBUpNjwMTBqhrkZNk2TGPUNK9iCAUiPXp7kYLdNBshfRer2/Gj9MbjOi2kcLmYj5W08
	 C1TMrLveiTB3K0V+XfvOGl+wqPyzYctXRicu60crJJ5whN3n5xME6DAfiM8sQIsO7mBEs
	 09GFKNnSVN7693h3vVRWCKoYsjCCablTPsm+lPr03bFGM27uceyLY6E/Wr+KZ9+EL1nNI
	 XSCgFrMnu86aliyWJjQAiSG3NfeGt4XcxnkHMYU9bKGkQMFDgEqums8eARtt/rR/viT1J
	 0o+GbNzHzDIFDSNa1I2eJOuR0kktzPPGfTGB5hq9jOiiRnjw1fCnWnuDtEz5nzMPvYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L7d8/uJE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B8606A31A;
	Mon, 23 Nov 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7d8/uJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AF21F000D3;
	Mon, 23 Nov 2026 07:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420287;
	bh=ZHQEKf1KqLu6uI/mLLyIWsaJG4xlK8Pi3bGb30llIjQ=;
	h=From:To:Cc:Subject:Date;
	b=L7d8/uJESRtD5e0mx+my2snjsiw9FiQ0asm4TcO0CWsAaY0u9RtTr8Zys7ojjvJ1+
	 s3LfF0CLM+GrYZa13ilZFwQ7TcCXStCvKl13hDPdfbb3kbtsIiBhCQHeAfdNWpj+Ib
	 dc4gANj0n5JDZuAOgXLvhFZdRMORKGCNMXn2Y3eKdoS4Omzf6A4U0TGHi9J1WIJF0j
	 1PbsQCRaWx/j80OjZaxI8AIELdD0fbVH+DSKdbPAzGvG+SAVqcDVeFYdSU5HQ0CvAz
	 Wy+ZeXkRoAD71+Gm6yIvOm6iTBAUcWlCp3ikXo4ldk7PHRPOd1iKD3dzhoJchjRiF7
	 b+8SHkTHug1HA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexandru Ardelean <ardeleanalex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bogdan Bolocan <bogdan.bolocan@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux@analog.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Radu Sabau <radu.sabau@analog.com>
Subject: [PATCH v2 0/7] iio: Fix memory corruption, teardown races and bounds checks
Date: Mon, 23 Nov 2026 07:50:26 +0000
Message-ID: <20261123075122.373060-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These issues were reported by Sashiko.

None of these changes have been tested on physical hardware.

v1 => v2:
 - Drop the 3 patches already applied upstream (stm32-adc x2, tsl2591)
 - Rebase onto fixes-togreg
 - CC Radu Sabau on the adis patch (Jonathan)
 - adxl313: Return -EIO on excessive FIFO entry count and -ERANGE on
   sub-base ODR codes (Andy, Jonathan)
 - pac1934: Order local variables in reverse Christmas tree style and
   scope the loop index j to the for-loop (Andy, Jonathan)
 - qcom-spmi-adc5-gen3: Manage tm_props and the OF node reference via
   adc5_gen3_aux_device_release(), register auxiliary_device_destroy()
   with devm_add_action_or_reset(), and return -ENOENT on an empty reg
   property (Andy, Jonathan)
 - isl29501: Use HZ_PER_MHZ, group range checks by variable, and order
   local declarations in reverse Christmas tree style (Andy)

v1: https://lore.kernel.org/all/20261119153151.1397003-1-lee@kernel.org/

Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Bogdan Bolocan <bogdan.bolocan@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux@analog.com
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Radu Sabau <radu.sabau@analog.com>

Lee Jones (7):
  iio: imu: adis: Clear pointers after freeing in
    adis_update_scan_mode()
  iio: accel: adxl313: Prevent FIFO buffer overflow in
    adxl313_fifo_transfer()
  iio: accel: adxl313: Reject sub-base ODR codes in adxl313_read_raw()
  iio: adc: pac1934: Fix custom attribute allocation and channel bounds
  iio: adc: qcom-spmi-adc5-gen3: Free TM auxiliary device wrapper in
    release callback
  iio: adc: qcom-spmi-adc5-gen3: Reject empty reg property in probe
  iio: proximity: isl29501: Fix division by zero and overflow in
    isl29501_set_freq()

 drivers/iio/accel/adxl313.h           |  2 +-
 drivers/iio/accel/adxl313_core.c      | 13 +++++-
 drivers/iio/adc/pac1934.c             | 33 +++++++--------
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 59 +++++++++++++--------------
 drivers/iio/imu/adis_buffer.c         |  2 +
 drivers/iio/proximity/isl29501.c      | 13 ++++--
 6 files changed, 68 insertions(+), 54 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog

