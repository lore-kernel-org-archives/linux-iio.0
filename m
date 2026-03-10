Received: from mail.imp.bg.ac.rs (mail.imp.bg.ac.rs [147.91.50.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7292FFF90;
	Tue, 10 Mar 2026 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.91.50.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156728; cv=none; b=evrbyV+gBMQJl1dNEpGXE3lwAVYjl+XFZaOKZA75tpNAuo3WGDL/Ty9W2o1kcVHX4feKK730wPEVNS8A9+mgj7M8TBp/bRSM4hn/ghQkZEncbk2FS9yCv17NOd+VbkwV8hLQIPdJcsVNhgWR1LfKkYnQ5UHRub+L5cnWEhc111w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156728; c=relaxed/simple;
	bh=HWXUxNP24ZxwPDxXd/1kdGPY1x0SNvyp4hczIWz8Ysk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VKhvmfhpWlsQnPNjHbb0aZX5hwLw55YVr+GUCIflxUvedvEc6ImAJo2fbE93CCmHgp2l86Rq9OQ2ho3RVDkadCHRhzxA4XyisoDpoC2ojFXDSfyp8V8SU07PC5puKTMqxPUx+M7CPnyopanNjVECWk4+Fs6QzTfUwz2f3aImlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs; spf=pass smtp.mailfrom=pupin.rs; dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b=GaIoZX8c; arc=none smtp.client-ip=147.91.50.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pupin.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b="GaIoZX8c"
Received: from localhost (localhost [127.0.0.1])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id 09817140C678E;
	Tue, 10 Mar 2026 16:32:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pupin.rs; h=
	content-transfer-encoding:content-type:content-type:organization
	:message-id:references:in-reply-to:subject:subject:from:from
	:date:date:mime-version:received:received:received; s=
	dkim20260301; t=1773156725; bh=HWXUxNP24ZxwPDxXd/1kdGPY1x0SNvyp4
	hczIWz8Ysk=; b=GaIoZX8cTkbysKe0+ngoJqAcWxyqiHFaiNqvCs1bD3KnLMB5V
	jCFA5koSvPVyp1Rawj0xEJgkAKGKKWxRlf4BOKq5X6u70WHl1RCsU/arMkddfc9N
	xTz3XOZph0Q701Nt+gopRlSiqnxkjJQ9pYJ6gF2LUoOdhNikKzHeGjTHAY=
X-Virus-Scanned: amavis at imp.bg.ac.rs
Received: from mail.imp.bg.ac.rs ([127.0.0.1])
 by localhost (mail.imp.bg.ac.rs [127.0.0.1]) (amavis, port 10024) with LMTP
 id XOp8DqG6FI5A; Tue, 10 Mar 2026 16:32:05 +0100 (CET)
X-Comment: SPF check N/A for local connections - client-ip=147.91.50.99; helo=webmail.imp.bg.ac.rs; envelope-from=david.marinovic@pupin.rs; receiver=jic23@kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.imp.bg.ac.rs CC70F140C38F9
Received: from webmail.imp.bg.ac.rs (webmail.imp.bg.ac.rs [147.91.50.99])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id CC70F140C38F9;
	Tue, 10 Mar 2026 16:32:05 +0100 (CET)
Received: from unknown (unknown [147.91.52.213]) by webmail.imp.bg.ac.rs
 (Roundcube webmail) with HTTP; Tue, 10 Mar 2026 16:32:05 +0100 CET
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 16:32:05 +0100
From: =?UTF-8?Q?David_Marinovi=C4=87?= <david.marinovic@pupin.rs>
To: jic23@kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 michael.hennerich@analog.com, devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: dac: ltc2632: add LTC2654 compatible
 strings
In-Reply-To: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
References: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
Message-ID: <4915e1023c72d2681b0c4ae028ec609e@pupin.rs>
X-Sender: david.marinovic@pupin.rs
Organization: IMPT
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Add DT compatible strings for the LTC2654 DAC family variants
supported by the ltc2632 driver.

Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
---
  .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml        | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml 
b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
index 733edc7d6d17..7ec663beec1a 100644
--- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
@@ -4,14 +4,15 @@
  $id: http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#
  $schema: http://devicetree.org/meta-schemas/core.yaml#

-title: Linear Technology LTC263x 12-/10-/8-Bit Rail-to-Rail DAC
+title: Linear Technology LTC263x 12-/10-/8-Bit, LTC2654 16-/12-Bit, 
Rail-to-Rail DAC

  maintainers:
    - Michael Hennerich <michael.hennerich@analog.com>

  description: |
-  Bindings for the Linear Technology LTC2632/2634/2636 DAC
+  Bindings for the Linear Technology LTC2632/2634/2636/2654 DAC
    Datasheet can be found here: 
https://www.analog.com/media/en/technical-documentation/data-sheets/LTC263[246].pdf
+  Datasheet can be found here: 
https://www.analog.com/media/en/technical-documentation/data-sheets/2654f.pdf

  properties:
    compatible:
@@ -34,6 +35,10 @@ properties:
        - lltc,ltc2636-h12
        - lltc,ltc2636-h10
        - lltc,ltc2636-h8
+      - lltc,ltc2654-l16
+      - lltc,ltc2654-l12
+      - lltc,ltc2654-h16
+      - lltc,ltc2654-h12

    reg:
      maxItems: 1
--
2.50.1




-------- Original Message --------
Subject: [PATCH 0/2] iio: dac: ltc2632: add support for LTC2654 DAC 
family
Date: 10.03.2026 16:27
 From: David Marinović <david.marinovic@pupin.rs>
To: jic23@kernel.org

This patch series adds support for the Linear Technology LTC2654
quad DAC family to the existing ltc2632 driver.

The LTC2654 shares the same 24-bit SPI protocol as the existing
LTC2632/2634/2636 devices, requiring minimal additions to the
driver.

The LTC2654L-16 variant has been tested on a Phytec phyCORE-STM32MP1
board with the DAC connected via SPI1. The driver probes successfully
and all 4 channels are accessible via the IIO sysfs interface.

Patch 1 adds the driver support.
Patch 2 updates the DT bindings documentation.

David Marinovic (2):
   iio: dac: ltc2632: add support for LTC2654 DAC family
   dt-bindings: iio: dac: ltc2632: add LTC2654 compatible strings

Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
