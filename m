Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9B331EBE
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118862; cv=none; b=TYW8JMDzcFUHEzE9Eap/rG0dXoaMQN1Xpci83i2oC7+8EaO5TzZGPENjqKAQExx/CH1Pa3MooEFEohBhn+pri2mgwekFFJqOtN4WoNeVsixS7hAPsG9MRkR2MQtCLvqYgGBko5LTqwusaj5j1tYBCOcudNvS1Z2i+BBfwOjVYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118862; c=relaxed/simple;
	bh=fcucwX/1fJ1pOAzQeFIwTEqmRsynKLo8GA7qEXR1p8E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f4fH1W4XmGLe4MIsfyZQsDqwAv0DN1VE7W2ZKfMx/I94AArKEKv5XLRwKi+UYOKkDE5ZNPOIALSIqaBxzs+oKcr/HuULPS7gJzMFvnJdcc0Cz885mPA41FPKYBMqqRrfuN9DXZS42JVhCqG9FkmPuvSfufIy2lKaP+IWY95dbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d10fNSI3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d10fNSI3"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e7457349eso196093985a.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 19:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792118860; x=1792723660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uj0TdCqgUSsVn4iGho22u4YPbfhCQ1Fhu0WCRIZbOB8=;
        b=d10fNSI3az16z3HpVfcycqnIhpSSV2JFLu9+9vk1871qVHLI0qKmeCrPA35dqpnA/h
         tFgoSZVJsUKb8NCtOOLNGcMSu6Y9hRV3SImIYNxbF6bj0BthIEmT21ojD1B2F0dcloBt
         +kUdmAyYUBjfVH0yjZZ13n135napwALtY2zI5+Agc5L40fTKMngDKpWgNqSpNznzcH2c
         MVkjjrdBMLi3vY0oBhG4ZYkdbbKvztZWuoBXSphhkhQZCTyvifhhatbcfC+1yJfGDBsW
         SREDPdlajU40BbeZp3S5niyUIn2HslGQlKWOIn+FU7MjTNcpOFXx1O1E38kFuE0nsAsw
         7Q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118860; x=1792723660;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uj0TdCqgUSsVn4iGho22u4YPbfhCQ1Fhu0WCRIZbOB8=;
        b=WsxkV1+430pb7K5LxeVgtJ25e3qDidFovHxZ7qepkR/JTSxOAIWBUDaf5XRIelNxhE
         1tqK+Ezrg2t1+u31faXCZQfmzRYV2IBFhogJeE0F/U7YunrJrV1paJMkGguGrh381Z9z
         kYRlKQU6Vaa4nFNMKC1jjqe+JVDjOW93M7PEZQMNeKk+4Z3J9WTpD8kFfdornhB/5nMh
         kefy5jlZtyvkDZks0axxqtk40BzorlaRcBoqBT9uGm1q9VwrdOPQRfAT9PVusaVdwxQc
         eMHx6w+UY/IyrG/J49mBYl9BbcWNvO1QiPHVpmbWFV0D4BhNgVVKhcU0XmFAIOv31wYf
         v46A==
X-Forwarded-Encrypted: i=1; AKwUvBxSGy90m0LCKwAMRZs+AA2/H1OIUOlypyr6ecctazKsMhIMw9uRIYlyn0g2W5E0HpyFkQkE+lTItS0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJw1Axf5VnBlJk4UitORH5GLHJg0Q+xKmg1HRXiG0GJ3BqOw+Pv
	f4gnkc4ZzLddEFpL+YbblooUd/YnB6Ssm+uV2HdvXmyPbK6LUDNpBJ0=
X-Gm-Gg: AYBFou2gyj51pWQyZ7X4X+Y09HXn+uSjOdf4T+FU3ae7AJwT9spaGhqY8w2sRe81yFE
	hIrUhXdrZRn0v9wjFQ1zdWwBC5daxUD27wWqx5g+YOuEagkt5HFXcVCXl2ZVEZ8klore4OHaYNi
	XLZqWLCCiDFNuUSY1Y7O5GV+Ye/W6hV8ZvI8ezBheig1IfzW3WT+HcTxtS/SHpT021MKKPmHRPC
	POL+j/jri69De1YAnr4pJ/a1hSVQihZ0yPJFjCQ2LZVEwqM4TLpyXV6MI/Bjd6OKH442wdQ83MU
	LE5FJHO+Wg5/lvLeNNxFfFkazq+FcO1DqIPJX0Mg07azwmnll0is2b7GPs/ugZaCzfmxpcv2t0D
	s/1RL4TFni0qa8y9ww7oirNcc6oLxh5pXle9Q57gntBjrr+VYQrmR6qIdHHLJFbsYiUS9Zs0Ps9
	PlTSSd/Hx8VWSs6upMH9YZi7KS/IEp5brLxno6fnj6lqxz1TRwSiDhGwJgBfGjjjIP2MP4SV2g/
	TOyOoofqToVMwuw7kFHRFRjsxun/YFzxcu42TP1oAK0pgArmh1lRKWtAEH8AhhfCfmk9Sy75Eof
	ypx5jSqKPB2c8SroPclNLqkLbCXZ
X-Received: by 2002:a05:620a:8084:b0:93e:54fb:1568 with SMTP id af79cd13be357-93ebd28aa3dmr3297591485a.52.1792118859714;
        Thu, 15 Oct 2026 19:47:39 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a16b5d7sm93545585a.12.2026.10.15.19.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:47:39 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] iio: proximity: hx9023s: Allocate trigger before requesting IRQ
Date: Thu, 15 Oct 2026 22:47:35 -0400
Message-ID: <20261016024735.3667060-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An IRQ handler that already read trigger_enabled can poll data->trig
after buffer disable. Detaching the virtual IRQ does not join this
physical IRQ, and trigger deselection can drop the consumer reference.
Devres may then free the trigger before joining the handler.

Allocate the trigger before requesting the IRQ so devres joins the
handler before dropping the allocation reference.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Compile-tested with GCC, W=1 (x86_64). No runtime testing.

 drivers/iio/proximity/hx9023s.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 0199a63..2a6da55 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1133,14 +1133,6 @@ static int hx9023s_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret, "reg config failed\n");
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(dev, client->irq,
-						hx9023s_irq_handler,
-						hx9023s_irq_thread_handler,
-						IRQF_ONESHOT,
-						"hx9023s_event", indio_dev);
-		if (ret)
-			return ret;
-
 		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						    indio_dev->name,
 						    iio_device_id(indio_dev));
@@ -1150,6 +1142,14 @@ static int hx9023s_probe(struct i2c_client *client)
 		data->trig->ops = &hx9023s_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
+		ret = devm_request_threaded_irq(dev, client->irq,
+						hx9023s_irq_handler,
+						hx9023s_irq_thread_handler,
+						IRQF_ONESHOT,
+						"hx9023s_event", indio_dev);
+		if (ret)
+			return ret;
+
 		ret = devm_iio_trigger_register(dev, data->trig);
 		if (ret)
 			return dev_err_probe(dev, ret,
