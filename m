Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640704399F2
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835754; cv=none; b=qePKQw56cHdEKHhq461lA3A0mIkiDsxkyiv8HmwOMKQELjOQtOh5ISYxt73V/+q+Wr/H5LZe/grtVhDbZzQ0ZJB1v7SRDwV7kc+lxncjtgYs+9LOZLWzXeqceebW0wW72RIxvPqVsTQWKN9o8ccNmlrNptYqC7n1PbJamW2mjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835754; c=relaxed/simple;
	bh=g5pvvLDDA8e8SK8t163DUxOqaajy5P7PnoCnQiF0AL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njJezvRHcme7zVAs9EciGgu9sIguwpkxN6gKGpNlu9qSL2wsEVkSZRH3xLSlze1VzQnSr7Qw0dL72fEjUIGNzP1FRtG4b450gfyUrxsrfo5jK4IN0NC1Pdnb05yJIfBeaHJTBqZTtBuJ8kG3zMXjROvnb47pux/vMcS3y0OlYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eucnetgi; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eucnetgi"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b83459526so13062006d6.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791835751; x=1792440551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C0KX/4YQfkF3CX/9lC7wI9xIJdxtt1Ct5vtM/wKwP6A=;
        b=EucnetgiIvLmAqmDIHxnrsBbe517AvmCAD0TgPNfmtveIgIRXUvlmWVY74dFyGp0fs
         /T2cMq4SELQk5BO01L13lDcdjHdIQtO24Ms0DX43XlYWeKWROVcddq3VdTI29jBZGNXq
         342ouCpP6rhbpMWQxKyZBdu4KyUmW+NLYam4IbrhYazOFrdF0G1LBcBtrhaKV6hurxFT
         U+MP1sx1/lLcUul/qB8mTfj08nimabOrpbopnhDqdJovxLUcAjwo1+4pp1DpBJNWcdIg
         C2MVTWFRHhH4Z2GVVNFiUJIA9L8MV2RYGsxgHW+ONapd77agpWgp6bl6F4pHH++Fumv4
         77Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791835751; x=1792440551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C0KX/4YQfkF3CX/9lC7wI9xIJdxtt1Ct5vtM/wKwP6A=;
        b=jNVoXGKRNWldjWYzS8xEOkgr/c2MUx9EThRsn0yz1Cu9wO83yVw0KMvJntKVImtu41
         lIUPdDJdQmOo9ezB4Sb+xjASHjPTdPxe+CfYuFdB+zcGpdOewvV0RR/hArseVIGOxbcE
         p0VJIIwQOsXDVGZBik5uEI9PzVlTYtHn6V24uwW7TtthhgbZ5Sa1RR+zkUzZC70FU0Ep
         9FJZMaNbiDA7pf8W4VJnEE+1FEHbGnL/1+Z/EyHsMTKRAtA5aqbP+tpoKocHyrtbJQdf
         9NA9ROWMGYxIoU85l89/FclQO2g1+HxwfLER4TPzAyQtT62Ya0EDH9vuBQT4oZc9GlYq
         CVtw==
X-Forwarded-Encrypted: i=1; AKwUvBynESJxA1bxGP2EcoBSoF/C3IFOX0zlB30ShK5Xc4ldOzIDH6rQN6qzDB7Z4snFox9qpVI4aL6rI/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpATCBSkUERFr0QMiVTSOg1mTcyCqFbE9AzNFK6ncA531kkPYP
	TO0dUUVF+pVogkziJlICcVL9oG6zUUOpyNSsaxFHaVkDJLKje2QFbyjE
X-Gm-Gg: AYBFou1miwyZqo1v5FZJKc18Vp624TF+JCN7skTr8IlrjbMXGj+E9bfWK7sqQzq6d64
	m3HxDDJcVS8niJvr5dRRYkmMKA+HzI+M6ABiSB+HWufgeY/c+5Q4maX6eRz5f1gA26t8kq1iA6F
	bBizUfG4kG3Cxu76bXOK09ZMXg5MwShL9MlaBVfj4l7womM/ipDM6BGi0JjLeCi0mpun0WhTKII
	g1OLMNJBED1BcQgCPCM1koYH+/+yiZYGxbnTzZMnbowNrjHu4/k03rgyVBaON/L5P/2YPD99TrA
	7sZ6IuAQu2AcnhMpdko6aLXe7fvq4cMXT4LK//jCuHGc7h+nCyNNvSsTGrUpQ0+3tJRlgZzG8IP
	rV7aeaA6abvRPfeBYQOExZyzEvm/yLnAzOatNzJJ/zO6EKN9OGkKdz01aQVfWExb8dfi5BUcVQ0
	bWYZJ0x4s6Yxp/t5SmtlS6FxNhnhsJvzb+U3xnxLgWoVZKtm7SrRs+D+fawCEFf/Dohh7DKNWxI
	+OKbC2sG7QKi+Wk6pTWA/fqyOqy6KV1v0M=
X-Received: by 2002:a05:620a:2992:b0:93b:e5e9:23d9 with SMTP id af79cd13be357-93ebd229343mr1629066185a.23.1791835751063;
        Mon, 12 Oct 2026 13:09:11 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b978387f7sm6664786d6.6.2026.10.12.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:09:10 -0700 (PDT)
From: Dingisoul <dingiso.kernel@gmail.com>
To: joshua.crofts1@gmail.com
Cc: andy@kernel.org,
	dingiso.kernel@gmail.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linusw@kernel.org,
	linux-iio@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [BUG] iio: gyro: mpu3050: use-after-free via trigger left on iio_trigger_list after unbind
Date: Mon, 12 Oct 2026 16:09:04 -0400
Message-Id: <20261012200904.1853361-1-dingiso.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261011190522.79da3607@systembl0wer>
References: <20261011190522.79da3607@systembl0wer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joshua, Sashiko,

Sashiko's concern is really about not being able to tell whether the
trigger was ever actually registered before calling
iio_trigger_unregister(). There's a precedent for this exact bug class:
commit 3c5eed894efd9 ("iio: temperature: tmp006: use
devm_iio_trigger_register") hit the same
devm_iio_trigger_alloc()-but-plain-register() mismatch in tmp006, and
fixed it by switching to devm_iio_trigger_register() instead of adding a
manual unregister call.

  https://github.com/torvalds/linux/commit/3c5eed894efd9

devm_iio_trigger_register() only installs its cleanup action if
iio_trigger_register() actually succeeds:

    int devm_iio_trigger_register(struct device *dev,
                                  struct iio_trigger *trig_info)
    {
        int ret;

        ret = iio_trigger_register(trig_info);
        if (ret)
            return ret;

        return devm_add_action_or_reset(dev, devm_iio_trigger_unreg, trig_info);
    }

so it can never unregister a trigger that was never registered -- no
flag/pointer tracking needed.

Suggested fix, in mpu3050_trigger_probe():

  -	ret = iio_trigger_register(mpu3050->trig);
  +	ret = devm_iio_trigger_register(&indio_dev->dev, mpu3050->trig);

(same scope devm_iio_trigger_alloc() already uses a few lines above).
With this, both iio_trigger_unregister() calls in your patch can be
dropped.

I rebuilt with just this one-line change and reran my reproducer:
the trigger registers normally on probe, and after delete_device 
it's actually gone instead of left dangling, so the attack just 
gets -EINVAL instead of a UAF. No KASAN report, no warnings.

Happy to test further revisions.

Best,
Dingisoul
