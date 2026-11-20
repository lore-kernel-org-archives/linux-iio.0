Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166469;
	b=281WOgeebqCtFNHb6a3YkYreP+cgGQ3yw66aIVPCtl/30Bd5CNZ56oURGdXs/JiynFyc
	 iW/a1/fx1Jr8+4SXExC+WIk2oK0vNrupahvWqgjmHWcM2Y+SgohZM3wsYrVhi2cTCQjW0
	 znPvmC23VHh1G+YobogjTXiDV2R2+kRu7F/DqecslpAy4Bf6VqFnU1cw90H1dQ/ksG3nw
	 CPQyCYhfd4dij3t4d8rZW2vBGS4nCV9rsbeuqwJq+LyaTnZ9Aq//wQ3aNS7VlOLLwla0L
	 6UEBEsOMxSYOzyCGKavuGLelSGie4BzbZpqwFrd/9UwCyfSgRvyfDjOUw2zCr6VwwJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9MeczI24AeGQ60e/giCR3Aaq5ecAvTmY+gYG4So0AwA=;
	b=hEr/4FfsQuiL8dve+ot45vAr9k2X5FXSnR3OJkJScNz2g+MQw/aRt6d/ak9slsrZMBmH
	 y0dW8Bs4jUnGOwtV3dfyY1clLPYiKTu93aly2TCQBTQSvRJiQnMNKlF/SnhUZl2DhbWFc
	 flyAoSB43ExaR0U759WRxXN6unWlYCY/jCCerfRp498WNzBxRdORigAEng6CyvP5DagYo
	 WlyL5acaAuXBQCN44DMWidYYrJr6+T+1TD6vy0vc8KnF58wBj5EcHjwzRWEQ3ZJWYH5XD
	 lWcMzdc67cO8VxDski9Jo5y9wpEU4KG1lK18CTWtbrTbZhFcWjHdiesmxP/0oEBFuBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rQ3g3y2I;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CA606A32A
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 958CA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rQ3g3y2I
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f02ee04378so5264965ad.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795166468; x=1795771268; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MeczI24AeGQ60e/giCR3Aaq5ecAvTmY+gYG4So0AwA=;
        b=rQ3g3y2IL2zrMre3y5vaxvoU2PJFhCxhGGu3jL5PeGB5tkMt3DNDpPCsZuFu4lpNLv
         Nrt1lzQGPj0HHKFbailIiiZNezPcmJHnJGnH1YOQV8g9TO9sNv4kjY/AeTzcGqQg4hTj
         dQdJcmJGK4qfmx09fQ4XRYYFbbdV6wP9MgXBgBmErOPNq/qHfY/t90GhKgOK/Z1fbXF+
         nlNzDhDbHtjlmPKUhSBmAN9h0I/SpSVxBCL5o+uayybp/M7oieExuh0Md/qznytR2NkU
         ZAkvFD9DlQ382LkZZ+Bbx1QDOlt1MsUcKglVu5/77F+C1Dn8JTs4LTYHBc3qkZDpmSt6
         Nq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166468; x=1795771268;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9MeczI24AeGQ60e/giCR3Aaq5ecAvTmY+gYG4So0AwA=;
        b=HSCpqM8tCKeOTRdKWW8VnJjtAOwcMJindg8LMq8xVh0qNJVnBBZhWJUoxG73rjgUHW
         h4/5j+Jr0lL323E17LuvX8EUrdGqH6JFCIhj0bQyVr+YICBGN+AfppNx6aX15QqipFM+
         He7WsqyPOyzP1PFbQufGV7wZnIbQJPDWg1z2EMCWmvZ8t6+d37UYZ9gddcDY9dzMeSLb
         FtG21FDXNkdZGGZRbH/EDOvrW0jMM5jb7sy51oqNcSbcWR2cFamqcbC7czfUzOMm+ZkP
         jyenTUJAwdMNHFppmti9sHPuf7n3r7Em77f9mJa3ka0/8PP6ry/rrgIBEAxew8klKCTQ
         cuDQ==
X-Forwarded-Encrypted: i=1; AL+hErGEBBesUDb7Q1DpW75Ar1bQsCSjt2Dl2NDf91MEl6UFzvdfI3ymC5HT7IIPu5qOcJIwLdqvjSgCna4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cUDcipldjMNNB1thZRrqA6h7qyvd3i14vhCJGJDOC6f6/myJ0
	oM3XuXebSwunnQztRk4LVk1g9buclIeVDva6kqZ6AwZxpAPsBnRMlvnB
X-Gm-Gg: AZFdTZdEaDnAc4Oh7cpNTVZ5H2RDIpb2aBlq+xaG2gCB5UHyEHjI2TGNYRueGKdtalx
	eLe3pgcJC68B5XRajYx+w5BJGmJqbdpGJ9b5LvBqUA62BUKvBeiLnIdvW5qSgguhw3bUwURYYIv
	e5nx2FXEi8WVEgWE0ujdVCplt8AArqwoZmYU3Iz8himpPm9QGUDfl6tivqeu6Ucunu3+KDvTixX
	i/ZvUNQyQSlJxMxZNIAu1TmdOAy6Y9Rm7hzLs7U6VqAuwW3cfVKPkCZ5OjatSXN7d0Aw+NhIA/r
	TAExigImWD3olAFI1mnAjVLBe4DP1aptct+ykq8PHBv8b8QZN3jct+L4Mb08hTvCsGNSw2sgQiq
	uGBoOvvNM6N4Dupb2Suufe/sGCnrDb7C6OeguBjLx3uULbKyp0ZbZ5/WIUeTfWIDieAArIDjANy
	JTZyCV3oaxviSNJ4d6R6hHJq0onhb6xRsBbPkaA/f+HWgxrDIMosAke5gvch6PjtictD/pmJIs2
	Eu1wGx7iZpxc14Qt6c/s/7flsLMr13doLnWhOPeIllydkQc8jeyfghdClYfdZAZFI7geK/2P4EJ
	k296rb+LruD6wNUholAAj8i86tm10YLMDiC2v07/3tFgKRBVhMpNLf0rAKQHi7Q8QJwu5w==
X-Received: by 2002:a17:902:cecb:b0:2f0:45a7:5d10 with SMTP id d9443c01a7336-2f045a76530mr15520125ad.8.1795166467860;
        Fri, 20 Nov 2026 01:21:07 -0800 (PST)
Received: from [169.254.42.106] ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1482c3sm11409575ad.73.2026.11.20.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:21:07 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspotmail.com
Subject: 
 [PATCH] HID: sensor-hub: Avoid holding spinlock across child iteration
Date: Fri, 20 Nov 2026 15:56:58 +0800
Message-ID: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

syzbot reports a SOFTIRQ-safe -> SOFTIRQ-unsafe lock order warning during
sensor hub removal.

sensor_hub_remove() currently holds sensor_data->lock while calling
device_for_each_child(). The child iteration enters the device core and may
acquire the klist lock. Since sensor_data->lock is also acquired with
interrupts disabled by sensor_hub_raw_event(), lockdep reports a possible
lock-order inversion.

The callback only needs sensor_data->lock while checking pending.status and
completing pending.ready. Pass sensor_data to the callback and take the lock
only around that short critical section instead of holding it across
device_for_each_child().

This preserves synchronization of pending.status while avoiding the lock-order
dependency between sensor_data->lock and the device core's klist lock.

The syzbot report is available at:
https://syzkaller.appspot.com/bug?id=3Dc7c429f6851638ece81338f90c5b29ac9c0dea=
1f

Testing:
- Reproduced the target lockdep warning with the unmodified kernel in 3/3
  two-CPU QEMU runs.
- The warning was absent with this patch in 3/3 equivalent runs.
- Ran the HID selftests against both baseline and patched kernels:
  hid_bpf: 45 passed, 1 skipped, 0 failed
  hidraw: 27 passed, 0 failed
  hid-core, hid-apple, hid-gamepad, hid-ite, hid-keyboard, hid-mouse,
  hid-multitouch, hid-sony, and hid-tablet all passed in both runs.
- hid-usb_crash.sh and hid-wacom.sh produced TAP 1..0 / rc=3D2 in both
  kernels because no executable test cases were collected in this minimal
  QEMU environment.
- No KASAN report, use-after-free, Oops, BUG, panic, or general protection
  fault was observed.
- checkpatch.pl --strict --no-signoff reports 0 errors and 0 warnings.

Reported-by: syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspo=
tmail.com
Closes: https://syzkaller.appspot.com/bug?id=3Dc7c429f6851638ece81338f90c5b29=
ac9c0dea1f
Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
Tested-by: Zheng Shuhao <viennaoffh@gmail.com>
---
 drivers/hid/hid-sensor-hub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc5..62799c26e6ec3 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -804,9 +804,13 @@ static int sensor_hub_probe(struct hid_device *hdev,
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
+	struct sensor_hub_data *sensor_data =3D data;
+	unsigned long flags;
=20
+	spin_lock_irqsave(&sensor_data->lock, flags);
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
+	spin_unlock_irqrestore(&sensor_data->lock, flags);
=20
 	return 0;
 }
@@ -814,16 +818,13 @@ static int sensor_hub_finalize_pending_fn(struct device=
 *dev, void *data)
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data =3D hid_get_drvdata(hdev);
-	unsigned long flags;
=20
 	hid_dbg(hdev, " hardware removed\n");
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
=20
-	spin_lock_irqsave(&data->lock, flags);
-	device_for_each_child(&hdev->dev, NULL,
+	device_for_each_child(&hdev->dev, data,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
=20
 	mfd_remove_devices(&hdev->dev);
 	mutex_destroy(&data->mutex);

