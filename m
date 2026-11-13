Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608784;
	b=FYJQDJOsQyseVhrV3Ib2oDNEjKXib+9ZZaEhwB9vLbkTOYjM0kjC5ysf9RzMd79bahNq
	 fizPlMlO+aFkSyRfVsvHAwJIdvXnhzBya2LojJwDymUxgZVDEMrhvqxtxDGgeBxrslKco
	 T9yjUjZvzn/pZar4UmJjZEmVmha0Z9FFrunMgNvy1dNkdU844i+hFx0Um+cEnLiZuyJ6b
	 I8wUjRtMgV6j2gpxZV9XtSBueLlzvML3n0I822GNWumxshEXyQzvntXuVpeZ8pxPBGRFu
	 RCAj0Q93ZU7VbYks5ldT4p7da9eE9qInKBmS+D+EpbgzoemZYBHUuF5RZyaKnkC6k9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FJtZRjKgFg90uSeT2CbjH35DbAO/VLflNjScs874eM0=;
	b=pDv87rf6dpT2gz1TnmHjnBUyBY8tkoK6U6JBszx5sCkNWoYv4FjIzNFqMpqeXvMK5Jf0
	 iYdYVJxwPWQ3S9u5o1cFBYwudBXNYonB5D3kJ92pfBys4TtoF2MlpwpFKG5PVwa5Ivq3c
	 wd0YNS1vC8ug+Eptz75DN75DnR45pwGDUpC6JxnEOfC8zyCB4Yi1XY/tNt8+ojo459HdP
	 MxEwyDzY//KPUW3kH1FOhbmeZRzSZvcqLO3N1L+K3I+aNcIXhfSMuyMijWxIH7qDmRnms
	 jRmDLWT+ui8q6rPpqZ9801nIv/6456eBGW39bfr6xX5U66ZeHH06VeXlnwI9XJaXAhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LW7hNVN1;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3973606A33A
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 22:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3973606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LW7hNVN1
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36fe5944e9aso1309833eec.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 14:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794608783; x=1795213583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FJtZRjKgFg90uSeT2CbjH35DbAO/VLflNjScs874eM0=;
        b=LW7hNVN1/QnvVg3UkSRF0jxLpcaRrLGgFRFHtoTIp+6N3hBqKASEMnp3c3ONAYNXIB
         7jBo9XudgJ8EIkIEllsKdLrMfSlZRyLVJdZ8ZTm4YPL9UDgC5a86mS9iNltY3TeJoPQq
         VIYQCAoJTy5pBvL9AXkZaPvnWvf5MWdM2LDqxvOyDnAgJn+LxqCq0jRm+igqA7BFh9ee
         4rIw+phy0fECX1Kjyis2LvKy5JFSMAIsW9ExuxQ4LGct2uLxK5UdUYSNoDKGAeGQwdAY
         qsBhs3qGX8pZeKwd/bXuBSewMym9Ays/JuRaznUEQdh1lliYtVopM+5/hBAuCyf0gjTl
         Beuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608783; x=1795213583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJtZRjKgFg90uSeT2CbjH35DbAO/VLflNjScs874eM0=;
        b=U5NVIv28Y9VYFNbP7uzfefrXxTddDoW2HOEKsmhn55SSd7RSP4v86y6PC9dVMfd2U1
         3gqQul/deE0zNILWIdEBLedEuFMnGgqplDpSz747R+m23X0UlZhtr3k3YzN3zml9LumT
         0PLf8qgXlhk0ScAZQiWdPo5HtvokKsx2ys6Mv7aaRaw6guCjZb04Nmrx9agfGob6750a
         NAlXOVJHf1McLJNOxE1Nu0td4VnyTYMvHdQ9HJwhTIn5S6YZUXmA/kWOAGTWZQU5Fi1G
         yugi/K1sQVE+e1KcdhsreAeymIXonzocHKrILWeylO4Hd9zA8qwrALXoS8mFBXJyTnJw
         zRBg==
X-Forwarded-Encrypted: i=1; AL+hErHih8UjRW9xO9a7m3DhicMUO7YMAVEYx/wAEKYLyKLFDYhTMjo6+mMR7GramePyG/iF9ai7qlVNWoo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5/V1ZPIuVSNGqQMUUyLLC/6kp150YnugBhN/8bhRa0zn9pU0/
	9v+LLgf3ZUx/sIgroufGIveUbBI7eg6rj0PlxFkqqstAQCXYva7pRjfj
X-Gm-Gg: AYBFou0ye+F0oKTk5jj+kg2q+gJ1btI9ITieVhouhkxNxYFNglI3ne5pzAuQLQYWFKi
	sq2wYc8hQnS+RFdsZe8jT7QtbD8LbyN7Ptk/6s10ZxewwjGatr4xvEVoP8nrk8GN8pyAOOZG2uL
	7avUrKTSjAHpqoG349iAJ5U6CE7ZI2t5rclvR0orV9HfoSjTV7ONF3pUVmYL2dR9xYcXAfuIDJm
	czPKhUbr5PNTeuEG+PTT0tYbsVLD3WaM+nS3w35iAlcomn6kKbuyKUqFF3WBjXQGdLMEAvze47x
	8GIpZuI7VaRIJ1P/L0OG3oF/ae9DtID1y6NrKEePftx84qPmwPLIdP4oUEaYJC1CcqHQEkRI43T
	kiBzwLSK+PElOWm9V+jElQD+L14tazeRZZDVZ+XG5G2OhMsuH/7/0pQgwfIlqboEZstocXjpE0Y
	kyXwPq9tV6igyoPBHFCvQKHiDvRTS+ugbG9DyxehH5NL4y1Cfg9fNc5WWOJKKy93bTIhgrZc4k4
	2IWNMVfFOz+JPQylyGoMUF1KEZBbKAGg87MDn9PUJcJ3ULMOlZauHlWi0XCQXthczJfUCWhUClY
	4ewE8IZEBFB+X0pt1PPRvvuFlGz/7k6V3sZa+L04+EwGbm3diVA96+GirQv4LuW8D9AMRr2B3Bp
	nLVs0T3Gpk59ZpDdOh2G0hwHvPQMLEVEUa7r1HRzXDVoYwIrocnwoLAC3CTE=
X-Received: by 2002:a05:693c:3e0a:b0:36b:d3dd:2e9d with SMTP id 5a478bee46e88-37966192e10mr3194904eec.19.1794608782828;
        Fri, 13 Nov 2026 14:26:22 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm17151380eec.21.2026.11.13.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:26:22 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: light: vcnl4035: Fix swapped raw channel readings
Date: Fri, 13 Nov 2026 22:26:09 +0000
Message-ID: <20261113222609.97564-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The IIO_LIGHT channel has channel number 0 and the IIO_INTENSITY
channel has channel number 1. vcnl4035_read_info_raw() selects the ALS
register for a nonzero channel number, so in_illuminance_raw returns
the white-channel sample and in_intensity_both_raw returns the ALS
sample. This also causes the illuminance scale to be applied to a
white-channel sample.

Table 13 of the VCNL4035X01 datasheet [1] lists 0x0b as the ALS
data register and 0x0c as the white data register.

Select the ALS data register for IIO_LIGHT and the white data register
for the intensity channel.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Link: https://www.vishay.com/docs/84251/vcnl4035x01.pdf [1]
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Reference the datasheet's register table in the commit message.

v1: https://lore.kernel.org/r/20261113110123.96084-1-dennylin0707@gmail.com/

 drivers/iio/light/vcnl4035.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index f1cc75245001..4bbb3b458eb5 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -156,7 +156,7 @@ static int vcnl4035_read_info_raw(struct iio_dev *indio_dev,
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	if (chan->channel)
+	if (chan->type == IIO_LIGHT)
 		reg = VCNL4035_ALS_DATA;
 	else
 		reg = VCNL4035_WHITE_DATA;

base-commit: 9752760146e642f3e4a2ec860f8767fa72030d2c
