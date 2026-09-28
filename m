Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293437E5C5
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629632; cv=none; b=jNOkYMuIhhqxD5Q8k0iQH2tjYfjUuFqeWWEdBpRxC9+ehTUT8W1GCehd3jYPgkpEROXPGVeTHX9olZgERJnMsdM6wbhN34XOFmZlLbELZlqtlLbfelCWl0LJJ33sv3CKHrqbq+pbBPSUW7wFF+tyI4t6R/yIad9DMPLnUlels/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629632; c=relaxed/simple;
	bh=s8Gf53x6SWGjNLlGqXuf8sFn3YnaaJcaKusJzWB3doQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Id1R+bD5qmMLPni5o8cIEK9MDPk9MjQ0uge1kuEj2lXE8QjyyJ2xx8RFpL5BtxqfYEKWuct3ShzE1xOzhH2wBwpPfat4a1gHijb9Ab86opnZkdFbfviagvB32OWoKtGh5urKiKPXlVOY3vA6I7l0Ka8vzM9RG0xgezqV5SzFvJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pi3x6Wco; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pi3x6Wco"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c59695cc9so212498385a.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 14:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629630; x=1791234430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQcC8QZhv7KRogPZte+j5/ydG1MU0uwz/clH6aQns3I=;
        b=pi3x6WcoXk726ZWuxbA054uRnYh1/QqrYZnAOzUA6nrZXOJe7+jKfGWbxpXJL8a4LL
         XghWkqKO8D+hUSX6q6zqgO6kX8D1rxk2MrkPfLLnb0Ox5BTU7pmDh+j4THuNAm0R4vXu
         Qa/A5nkmzylbwAKy12bpj6/U2EjMec6fvwo73HzXHpiITgkTOD5NWOkzi7PYmVb5uzdC
         FxcxHRWxJ8KOlQ5lFhh/+p9Y98wdDI/uWwu4xepNO58FSSY9ermxpKT9WSAXfy9EvxCz
         6PXviXEypguyHIoaGNsAA0nVZz3xMSeugOb7vrQHNdSUseoxDRUIq9MLE2r0d7jW0Qye
         zjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629630; x=1791234430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQcC8QZhv7KRogPZte+j5/ydG1MU0uwz/clH6aQns3I=;
        b=dYnkdOxqR73nnKH6QiQ3SydkkZwm8k4q906ZjQWdYueY9LOGVKhtmrLYb3UE9aMYQh
         CsCfa2ni6cpoTwwJrGftzfE9hPTKYIEzPSiSkuR5jXGnFUa1CApTNGH+01gP9WFE8tpi
         +VMu6MIwLqCSYbfz5v9AP9lEvpTZNEkQnzDgoEi8JKajhFUEq//DJMnb1Fo2OA0bCzg2
         Cwe+GxF8fhlB2e5iE05u1xOymIHqJ014iJleUsrGFC7KdIGoYUQNmWIihP6wVPhyoz6L
         puXbio/N6c7pEfDdcDnLz4++ctqCFqnUQ6TZs0QvUXmQUNdE9fTrPNQZJI2mhd28KrjP
         fdTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQZeY4vQFS10kQfZTtE4wAKXe5VRNeJzX3E4NqZbp0JI80QLbJlPmyHFhi0Eh6Y1zPEgev1rhh1oE=@vger.kernel.org
X-Gm-Message-State: AFuF++lgWe55YHLS2EVk2FYECeAQNTuzRYlryU+fn2xfF1EcXtGMolmR
	3YZUsCDcOJD2blWrcnqtMB5WQWDlgH9iavkx3vUUsOfc3EF6vRKFd6Fj
X-Gm-Gg: AYBFou2eDJeacnLbJp3CDHVlbF6y+mbIYfqzvBNWC0gHczznbfGM6expFm2wQzuJp7i
	HfvOTxKrriQRePGGP1Sz5D3cFtM+ae1IIXO3ExyXCq/K7oDgADhl9Hz3k8gHZ2V9gOzOKWrYXMg
	fVpBu8hCKpePd6nn7pbYNKKQRa34M8l/CKTTCjcqF++/EzT1UUwIvo76Bh2zGJXfbOrzzI0MTvS
	ba8VPcbz6CPyc1KiNwYyvbN3Js1B5wOFvYXqP39Dws6C1N8LUCoL6oKvXRC+ozioulKRJZsAG9L
	iI+waTpxa84uJtBCH2PIpcCj+NquttQYaPBZaNkp2P4ig1u3+XZscw19LdRkmKlZZVikHSPh4mH
	+RzvrGRgGk/KaVoyuN9jBXVA6NNPcBNnsLvszv/ITBb6O6ficqjusTMjxV/jvC96Kd8Laqt3PH9
	1DC1+LaP6ZJQmiugUfnuI98fJ+99qfHgrCV1Ct875H/LZYSiaoD82zL8QKOssH5TjmYAdRNTDDd
	Z576n6ZyYjlrx8lQ5aHC7ASDuzV4hpugzr74kXikjvCP6l+V+mETQ1PT/3AyckKLHbWfx4vPiXF
	4tbksN5u
X-Received: by 2002:a05:620a:40d2:b0:939:6de6:9518 with SMTP id af79cd13be357-93c43cd9749mr2136518985a.47.1790629629648;
        Mon, 28 Sep 2026 14:07:09 -0700 (PDT)
Received: from cachyos-SlimIce.lan (1841343-static.dvnpiaaa.metronetinc.net. [195.252.229.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c814342f9sm241348885a.29.2026.09.28.14.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:07:09 -0700 (PDT)
From: Jared Wuerzburger <jwuerz@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 (Minisforum V3 / V3 SE)
Date: Mon, 28 Sep 2026 16:06:46 -0500
Message-ID: <20260928210648.17166-1-jwuerz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This adds the SMOCF05 ACPI ID used by the Minisforum V3 and V3 SE
tablets for their LSM6DS3TR-C, picking up Samuel's series [1][2].
Without it the accelerometer and gyroscope are missing unless the user
carries a DSDT override [3].

Changes since v4 [7]:
 - 1/2: drop the Link: for the suggestion (Andy); add Andy's Reviewed-by.
 - 2/2: drop the DSDT excerpt from the changelog (it is below) and
   update the tag block accordingly; add Andy's Reviewed-by.

Changes since v3 [4]:
 - 1/2: convert the ACPI match table to C99 initializers instead of
   only dropping the trailing commas (Andy).
 - 2/2: explain in the changelog why the firmware's SLA0 matrix is not
   used and the orientation comes from hwdb (Andy); drop the pointer
   to the cover letter (Andy); Link: -> Closes: (Andy).
 - Assisted-by: LLM (Andy).

A correction to the v3 cover letter: SLA0 applied via hwdb gives correct
rotation but inverted tilt (it follows the Windows convention, see 2/2).
The correct matrix is -1 0 0; 0 -1 0; 0 0 1. The systemd hwdb entry [5]
was merged with SLA0 and has since been fixed [6].

The full STS device from the V3 BIOS (1.06), identical on the V3 SE:

      Device (STS)
      {
          Name (_HID, EisaId ("SMOCF05"))
          Name (_CID, EisaId ("SMOCF05"))
          Name (_UID, Zero)
          Method (_STA, 0, NotSerialized)
          {
              Return (0x0F)
          }

          Method (_CRS, 0, NotSerialized)
          {
              Name (RBUF, ResourceTemplate ()
              {
                  I2cSerialBusV2 (0x006A, ControllerInitiated, 0x00061A80,
                      AddressingMode7Bit, "\\_SB.I2CD",
                      0x00, ResourceConsumer, , Exclusive,
                      RawDataBuffer (0x04)
                      {
                          0x53, 0x4C, 0x41, 0x30
                      })
                  I2cSerialBusV2 (0x006A, ControllerInitiated, 0x00061A80,
                      AddressingMode7Bit, "\\_SB.I2CD",
                      0x00, ResourceConsumer, , Exclusive,
                      RawDataBuffer (0x04)
                      {
                          0x53, 0x4C, 0x47, 0x30
                      })
                  GpioInt (Edge, ActiveHigh, Exclusive, PullNone, 0x0000,
                      "\\_SB.GPIO", 0x00, ResourceConsumer, ,
                      RawDataBuffer (0x04)
                      {
                          0x53, 0x4C, 0x41, 0x30
                      })
                      {
                          0x0009
                      }
              })
              Return (RBUF) /* \_SB_.I2CD.STS_._CRS.RBUF */
          }

          Method (SLA0, 0, NotSerialized)
          {
              Name (RBUF, Package (0x03)
              {
                  "-1 0 0",
                  "0 -1 0",
                  "0 0 -1"
              })
              Return (RBUF) /* \_SB_.I2CD.STS_.SLA0.RBUF */
          }

          Method (SLG0, 0, NotSerialized)
          {
              Name (RBUF, Package (0x03)
              {
                  "1 0 0",
                  "0 1 0",
                  "0 0 1"
              })
              Return (RBUF) /* \_SB_.I2CD.STS_.SLG0.RBUF */
          }
      }

Thanks to Samuel for the original series and to Andy for the reviews.

[1] v1: https://lore.kernel.org/linux-iio/20251223025351.3099978-2-samuel@dionne-riel.com/
[2] v2: https://lore.kernel.org/linux-iio/20260201225450.1649001-2-samuel@dionne-riel.com/
[3] https://github.com/mudkipme/awesome-minisforum-v3/issues/2
[4] v3: https://lore.kernel.org/linux-iio/20260927220559.24169-1-jwuerz@gmail.com/
[5] https://github.com/systemd/systemd/pull/43935
[6] https://github.com/systemd/systemd/pull/43941
[7] v4: https://lore.kernel.org/linux-iio/20260928175049.86941-1-jwuerz@gmail.com/

Jared Wuerzburger (1):
  iio: imu: st_lsm6dsx: Use C99 initializers in ACPI match table

Samuel Dionne-Riel (1):
  iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 for LSM6DS3TR-C

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.55.0

