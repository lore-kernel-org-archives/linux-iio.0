Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440341;
	b=h70R9AHH58cY26738BZL7aCUkOnrags9mT3OnTNORoqs3IfenelAG26QJuKBQNI7xFL8
	 S611LJB2qgXksbN4Xf0uRLx7gAW394hOZEtWXOvHJ3sH8KBclkng/LX0ThEYtnW9qwCG4
	 ZUyLzWjpT8E9bjktsiiclEPkPMNIpCPEjqIN4MTx+cgwyVwkED6GVsJg7DhsypRv5JyE6
	 H6qNA4pM2RO0AI5YeLcDD1OGIhkttYNPUOCugskl+zkKxWnHRs6Tu9sSlniMPiD2RzUk0
	 SVbcbuVHErxydXyjYJJcSVvgvbrgn37/CAQ0snU4PActQSO4BOG8IooUjOG1B2sPp6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440341;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=U2l/PSpLzRM5oVQlGe6xz6RGGIu5itmp+X21coz1yzo=;
	b=kHVdET0c/Y5m7aQyhIHYovX6O5VLQgxodM8nzlkuO83PbV0aWkilvXzZlNW9UVK6Ir7W
	 TjfBdJn1S3aqLuCupmSWzCw5UPCLhdtCJzJ4/6gQKMp33thR/vlRqLgPvOhiUVdgbsot4
	 1FmGwkIDR0Db0XibcucVHl7cGmYsxj//N1c4oBXTNCqLt+5tk4MurEiuHG+flVS1WAuFg
	 gLU+CI3bXMubbcStcntINYmHoyYDuUKBMGi9N5N8JoRpK5q+mam5/LaSYXoUz8ePe2jmp
	 xG4vElAdz6XZ/6Uf85lyU6TNeUFEAI430ZPXfybkifboXbzjxguxyYcejpbvonCdR7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HJ/OSbAr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562A606A31E;
	Mon, 23 Nov 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJ/OSbAr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795440340;
	b=GpKQ3XOCGTBbpcE3uOvF1p5oIjt1GHbSF+c6K7ZEcEALsKei7mPLYv5EH8n1lygvX5aB
	 k1BHC3byIsT/HDECvabWNcJhyOMz7YRwqfgQPx6BRdgm7uUqhTSxaXDEKdUi5XXO7pZnR
	 FUDPBxEhZ+GrpyZgj18LovBzJsA47HXnJf0+E+yPbpQGgiUmrq/7xcsLHjsXkegz4ou4Y
	 d3041amKpJz+jqtUhh56nz7AdwoiWcViNbW3aLUgFmr7hU7KaS6x4ci3iQNtWP0Mzyn7J
	 eJdqgcWnaUUqv34wo1EfeMCHjA8kCj7XnOlpC6d5b08zUAn/hnL3erOjjAHJCuVHcxA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440340;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=U2l/PSpLzRM5oVQlGe6xz6RGGIu5itmp+X21coz1yzo=;
	b=J9aZCgYTMTAop3NFCMfyd0Tq9nruax+Wky66I2pYIYVy9G3+Al7dV3eAEcaSndFKkdzE
	 43i2iB+J6Tzl5ARs/Tj+6hHCTEXaBdi+5TMWPUylcjqLdK1D6u7ba7IHMamtgiBIkiwHo
	 znGd717Z+V3Or0zN6PmbKlSFhm57OvTiGbfefDnDbu60AQxCsZBVDLFEiQRFCW83o/C2X
	 Qlm9hrVJa/aN69EPkDXZZotQXxHKM93evO743qrqR3zCTqdg121a633ZIXdKYPasj2Vyk
	 /U8brFNTyh+CPtKATTIihzKSnDU/S+Q6ZulCJy2XuySK96TMVxAM1lBOSjepMTzSbfw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E86DF1F000D1;
	Mon, 23 Nov 2026 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440340;
	bh=U2l/PSpLzRM5oVQlGe6xz6RGGIu5itmp+X21coz1yzo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HJ/OSbArpyCdZuGEmUtQlUIeLh7aV5yUea31h6v1tGU8If6TRYa7ogFxIL3wzIpt9
	 CNyRJIFx5lQxX6wPkd0ksi+xqfW+E5TjEHxevZzsF1P9aFCheEqZIqIWNlZhl1VRtm
	 R1HjmSI+XsLUDKBb88mNuSvP4AUb6lwwZner8ipb0evIKy7Q7HGHKkooWxNnEO6L5d
	 dVoTQLYdUya0fCOupwxAGTJ4crzoknq8mkZABbdC3Sl/wJ3+LoVzOGFMih5AZzY1y1
	 jvCKoN59hzcDsWmobGhQxSH8o7GawHV4RatOOodbrqc32+iOzKGbzcAdP1AGHT5BGb
	 8baQjPAhoT13g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 462384C491;
	Mon, 23 Nov 2026 13:25:28 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH 0/7] iio: imu: adis: Use a kfifo buffer for the devices
 with a FIFO
Date: Mon, 23 Nov 2026 15:25:24 +0200
Message-Id: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQ+BGsC/yXMQQ5AMBBA0avIrDXRFkldRSxapowF0kEkjbsrl
 i/5+REYAyFDk0UIeBLTuiTIPIN+ssuIgoZkUIWqpVRa2IFYePKrUMYaVxrttasg9VtAT9f3arv
 ffLgZ+/0dwH0/ZDATHm0AAAA=
X-Change-ID: 20261123-adis-fifo-29a9b493f3b5
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
 Radu Sabau <radu.sabau@analog.com>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795440327; l=4260;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=oKCpDg1HZTgPCiyY2NCccMqSlWCKSdLi45bhzaZepAo=;
 b=YKFQ8nUlf2/y9HWQd8KehMXf94OXNUgdoFmVFs48ax/9kIG9ENA2XBp/TzwULNIZhDKXi+GvR
 Rm8/BzjVpYtDtBcpasUlQBupOSdRqj9/alZ4d1rDwV8M07RHQrRZp5W
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

This series follows the ADIS16607 driver, which was applied without its
buffered capture so that the adislib part could be done first, as
suggested in the review of that series.

The devices with a hardware FIFO (has_fifo, the ADIS1657x variants of the
adis16475 driver so far) capture through the triggered buffer. Their FIFO
interrupt is requested with iio_trigger_generic_data_rdy_poll() as the
threaded handler, which calls iio_trigger_poll() from the IRQ thread, even
though that helper is meant for hard interrupt context, and the capture then
depends on whatever trigger is selected.

Patch 1 is a fix on its own and does not depend on the rest. The ADIS1657x
variants of the adis16475 driver wait less after a reset than their
datasheets give, so the product ID mismatch warning is printed and the
registers written at probe are lost, including the FIFO configuration. It
was found while testing this series, and comes first so that it can be
applied separately.

Patch 2 adds a helper to adislib that sets up a kfifo buffer and requests
the FIFO interrupt as a oneshot threaded IRQ running a handler supplied by
the driver. The interrupt is requested disabled and the driver enables and
disables it from its buffer setup functions. A second helper registers the
trigger of the same name as before, for the devices that already had one.

Patches 3 and 4 convert the adis16475 FIFO variants. Patch 3 passes the
device and the timestamp to the sample helpers instead of the poll
function, so they do not depend on being called from a trigger handler,
and patch 4 does the conversion. The trigger/current_trigger attribute of
these devices is kept as it was, so there is no change in the interface,
but the buffer does not use the trigger any more: writing it is accepted
and has no effect, and a buffer can now also be enabled without selecting
one. This is the same approach hid-sensor-trigger takes for the same
reason.

Patch 5 removes the FIFO handling from the data ready trigger, which no
device uses any more.

Patches 6 and 7 add the buffered capture to the adis16607 on top of the
helper, and the reporting of loss of external sync, which was left out of
the base series as it is reported from the FIFO interrupt handler.

Notable points for reviewers:

 - The FIFO interrupt is level triggered and oneshot, so the line stays
   masked until the handler has drained the FIFO, and it is enabled only
   while the buffer is, from the buffer setup functions. disable_irq() is
   called without the adis lock, as the handler takes it and
   disable_irq() waits for it.

 - The adis16607 does not register a trigger: it never had that
   interface, so there is nothing to keep compatible. The helper that
   registers one is only called by the adis16475.

 - On the adis16607 the device cannot mask DEV_NOK by itself: unrouting it
   leaves the pin on its weak pull-up, which reads as asserted. The
   interrupt is therefore masked on the host.

 - The series was tested on a Raspberry Pi 4 with an ADIS16607 and an
   ADIS16577-2 wired over SPI.

Link to the ADIS16607 series: https://lore.kernel.org/r/20261118-adis16607-v7-0-707609737691@analog.com

---
Radu Sabau (7):
      iio: imu: adis16475: Use the reset timeouts of the ADIS1657x
      iio: imu: adis: Add a kfifo buffer setup helper for FIFO devices
      iio: imu: adis16475: Pass the device and timestamp to the sample helpers
      iio: imu: adis16475: Use a kfifo buffer for the devices with a FIFO
      iio: imu: adis: Drop the FIFO handling from the data ready trigger
      iio: imu: adis16607: Add FIFO-based buffered capture
      iio: imu: adis16607: Report loss of external sync

 drivers/iio/imu/Kconfig        |   3 +
 drivers/iio/imu/adis16475.c    |  87 +++++----
 drivers/iio/imu/adis16607.c    | 399 +++++++++++++++++++++++++++++++++++++++--
 drivers/iio/imu/adis_buffer.c  |  45 +++++
 drivers/iio/imu/adis_trigger.c |  73 ++++++--
 include/linux/iio/imu/adis.h   |  32 ++++
 6 files changed, 584 insertions(+), 55 deletions(-)
---
base-commit: f2cbef9101b9fc979a324bb1242b8b802a2484b6
change-id: 20261123-adis-fifo-29a9b493f3b5

Best regards,
--  
Radu Sabau <radu.sabau@analog.com>


