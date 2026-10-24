Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792864629;
	b=WaywYJUkXbl2vkZ9vQjKA4uyv9uAyS77XRdoLbEmJZDWmtuvnF37QVS7yXYQ9hkgqmtk
	 IWLW6IWzQxg/03rku1M3vGunkv4++ToyX4CpEHN+pxA66+hfsEoJLU/5VkRA9FgFU0Zpz
	 D9+8JN11i3UmSTDa8Pk/G26UuRu70X6A6WiDtQgyUlceFXwENHOBzA+kBk0/iIh+Q9pI6
	 JNxil+16vs2s4Vq4DHLa7UBz4lX8cygRc5ASZiXvXeDGvX5oLPCBl5AZz9ki+WSt4XDhC
	 3LeVHLDAqEahpigqq3STmNZpPbwes4F2QJIMWqgmOvB55CQUjb73zSPOCegM/FhOTRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gHrHyM/5fyejYWNArNua6ZlvykMFHKuFZPw+M6rELIk=;
	b=JxILOkicNrRXJy6rCMfkvScwlHtCcWmAtgizcDZJY7Tb0CosI2+UefiXQwnWVmUoVlqJ
	 q8agmSCVuGRy+AHIcaeNavgoxTF3IELmSEKDkre3OnFUsbI7X0GEqJEBf9cWByHhyqH9r
	 UphmwcCiQ5RmJyu6WvNIW++V6LVfW7p7trQkVvGXK9SXNgOROVe7yBkYcbA4bbW51KrCu
	 mucLLfmXFOpXMiU5rSKzWxpDUjVnht84oV+WwsbzPO6+posBQ8V5AJs7Vu3ezvXT01Jls
	 zREnO59NAaAuZhoyJCcaQye4SdPgUOFSZ+P8uH80nUgmf+XU8GsTMdVWzCsPq0kXk5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Je60pJkw;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358D606A31F
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 17:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D358D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Je60pJkw
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35b2c599f43so726888eec.0
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792864628; x=1793469428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gHrHyM/5fyejYWNArNua6ZlvykMFHKuFZPw+M6rELIk=;
        b=Je60pJkwg0vgqa2pDwqVNdZXAhghgfLuN8UJmrVfOSukQHu7PRbeMS9eCcC4R5xZf3
         9JLcX51AOLhxYrqn6H0zNlkLtYyd0LKc9/NagG8mtBRr6SbZNTUa0DPHS2YPQXG76H8b
         1dtY1CIeQ3w3QUXwMhYOKlUf+oVPrvYb/bPZEaG622fNrbtzsEq5HHRiVm2682Kq2L2b
         jW3TcjvScO118Qqg02mNgHRt/wi7sQCsQCIz5CxbVQ4MrDhBpHYp7aavDHvf2w+VhlL1
         Bu767YO1Txx0oWvo2loz9hRNnlxnfHZmRFwde92bohGwWngNzoi3p6BEYNSnCBfLPBv1
         kkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792864628; x=1793469428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gHrHyM/5fyejYWNArNua6ZlvykMFHKuFZPw+M6rELIk=;
        b=XGFh2bCi6D4JmPQeiiVrl1+pHaybFNidYMDYp8lmlBdwuqnF1RSF0CG8PjL90iEfEJ
         A8XSI+9kw1iFHTsAUKXQqBmeNHU3M2GDN0goadZPCQmpqNQFa8NMCBpj5Ily9BHUdiFg
         DZ4XfEgrpConWa8oiE81mN7wHBdtWVKY/ZrQ106+Kr+gZ0Isvfd8AhgG9VN+wUgZJ4vI
         jgwKKEt1mCEl+LwgdKCjel9hOxfnHg4MMHUQ5YiyaFcOmuxFWqniCQsjrN+4O98shL3R
         zkfWzIgyr54wfzDBJcjJYTwezPnON1p4rQFHglmphtxD1CFY+MwZAqSL2IITGVmhcGRq
         g/Yw==
X-Forwarded-Encrypted: i=1; AKwUvBxuRMlHMU6nGZHMWOj/PFRTgSvt/dEdJEcEO3+L8w2bBe5m1Acd2kSCa5+DpcRHaF+j3FP0KYQwC6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqiUh7vR4cLu3XKxqReXzzoMQ23hqvoygxkLugKkQIzwbHVOE6
	lW8dIR5YY0lIoJR+GpHZaohX6m2SoqHgVYry+7N57G20eXTBoNsCWi1Q
X-Gm-Gg: AYBFou0MSi2czCnM/oescir1exxZMCUUeEx0YALoNZ5I4wuP0j/oVbRLDo8f7VigHrv
	sE/Ri17NtSDVsArLIPeOuS8v0altmrOj8Ert4Tsb53l7djztotkigcm+vFX5fe0ONVQ+ssjRRYu
	zDXkt7OT7aWFTa9bfTKt5tC8pLCHaQcjn7EO4duWKMLNSIBJqtmhPAi0Il/edZv7TSZ+PbTvWlZ
	7WxxdaedpoCiuCBoqct+/0ttG6Dbq/f+fgiIctfjI+dMqlQ5Mu8G2cVTlpVDu0syX05UIxaCdKQ
	inj17ytZJjHCLlP/pi7j6Gj6gacwtjTxUESDNtz2qzyJyjWLjE/u9gqNqHjrdz5796GgedmybNf
	/aKbgbgLciqQwSdrg9LuDzgtkEjdfv77jVDekbkjfU0vOA4mT19Bjln/55QOwDxOTNc1E8Frr95
	3afn8UF384H4pBck9qQ9jpzFuHW7otAUubsrZvGPEsvPXpOUt6Ha8QHVRxA2GsTaaCXOnHFCE0I
	6tJO2DxYkySbi0XYVaVjJ86SatWIuz+yigR8EQYFh9o50rHWR+vNxGyaS5sR3JIFvu0MklmWcja
	cZYvomLTqxu8prM9Q8Dq/Sr2VG2egEg+igbqF8ZyUHzR5P/VVy3KmQu4jzHT3I3KHj+6H6paZ1T
	y1HNph5OcGtg=
X-Received: by 2002:a05:7301:fd02:b0:342:645a:5cf with SMTP id 5a478bee46e88-369e830ed89mr3796698eec.1.1792864627754;
        Sat, 24 Oct 2026 10:57:07 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d5b841sm10684217eec.9.2026.10.24.10.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 10:57:07 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: proximity: sx9500: ignore event config writes that don't change state
Date: Sat, 24 Oct 2026 23:26:53 +0530
Message-ID: <20261024175658.130546-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sx9500_write_event_config() adjusts the channel and close/far user
counts on every write, even when the event is already in the requested
state. Writing 0 to a disabled event and then 1 leaves the counts at 0,
so the channel and its interrupts stay off while the event reads as
enabled. As channel_users[] is shared with raw reads, those can then
wait forever for a conversion. Writing 1 twice and then 0 has the
opposite effect.

Return early when the state doesn't change, as
sx_common_write_event_config() does.

Fixes: 4193c0f1d863 ("iio: driver for Semtech SX9500 proximity solution")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Compile-tested only (W=1); I don't have SX9500 hardware. Both write
sequences were checked with a userspace model of the user counting.

 drivers/iio/proximity/sx9500.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index dadce9b44227..26522b6c5a2d 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -548,6 +548,12 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->mutex);
 
+	/* The user counts must only change when the state does. */
+	if (data->event_enabled[chan->channel] == state) {
+		ret = 0;
+		goto out_unlock;
+	}
+
 	if (state) {
 		ret = sx9500_inc_chan_users(data, chan->channel);
 		if (ret < 0)

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

