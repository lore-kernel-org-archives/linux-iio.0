Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6333DED9
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231828; cv=none; b=tpscEd0+Px474p5TteEchzi2Xg/6JlvgeYX3aZIfVS0zahG6B3KkOI4PVbCr1X10sJYj0zESJukrgfyQVjdv8SIrXA2/R/XG2/r36Luv10vwTkge8s5VM4ls8E+9Mx/I2Ni60KDz+gNzBFCpoCnIHSy8U+fQn0mDPYRTVT875wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231828; c=relaxed/simple;
	bh=hPD4uTpv+XOWMevzBsd2gEkzL4F+Qc48tU9mg8h4sek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ViaIDVF/Ayr3CQzsgbB4wbNFs6lqR/yfKoa4eY1LV5GLYV7k+SMmH/xOBMg98ia4moNDFQR3O4YSMxOvJlV+8bkHcNxsO4vex8DXc16AiJi8c1n5uWrVpBN6rm6o7hyaR8/HM31S6kUW1oH6RmFtmDuwrzA3i2HDz3r5JZHAMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvaLmuml; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvaLmuml"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso17657576d6.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778231826; x=1778836626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYvmQkrZ5hOjBgEihNCWESoDAFfbA5bcGWb1fL12DfM=;
        b=pvaLmumlxqLsqKVXv1YCvQPTBzLmCZvjUM3I5DP2i9tL+y6PBUcsZInfSRzYt9i9SA
         TO+BJtLhBEdLYqBPFRfoE56UPc90Nd+Vs4Vzdja4nVf0fjCAeThK1d3dYXTRvCs/mPsB
         iYpxK2VAyqwzGQLaF7RlBXivcAHbblmD8gnRKAxOU3E2j7ks/BLsYDCBDx9GC48tPto3
         Jp8kXBP3fn2oxW6V2pdHdiaPyCsPAV6wl8F5zdkP/m+Du4Ik7o/oStUp5xr0tH3pBgk8
         x2pjyro8WNFQkj1CD+rXdaOsx2Vs331lAOTsxr+HxrsuW1/OCLltREevPqRUfPuqdCHm
         nkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778231826; x=1778836626;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vYvmQkrZ5hOjBgEihNCWESoDAFfbA5bcGWb1fL12DfM=;
        b=s6ORQou7H7hhKqfgWHWT8G9ZbzPwqquZR6lNtMDZd/Ipvec7pZISmdfV92NQSM9CfW
         uhB1jFDKTq5RLYACnU9+Q8/HBz2SO9c3v6m4P0jrkgLsKkb42+nPKo4RmUYJFSGB2eMx
         N8gfaS+tqm35GwQO9Dcd93/prY0/WGxwsufDKhqZYkyZXTCXD/B9FEwSMRxIwd2yUpK1
         tzFSShlD+OTAeVz2IsHIgdaD75qiJk7K76qD+U6BP18Chz8PotuN3BGgYssyurglTsy/
         tMr237m+WBnnUwBcVQQba9JQgg9HpQFUrx7EtVhRn0sf+6jz5F/+Udoi90HHfIYBgwHs
         YeBQ==
X-Gm-Message-State: AOJu0Yx2G9TfrJGoLjjlKuPsgDTW7PnzGvYCEAe1ANPMlLhmvLUpcDWV
	8OPbSjSsULZ3+Ktx50GvfVPdSveIeVy1RyXXllqLPyuWVH417+ee95orbxMAfL20
X-Gm-Gg: Acq92OGFyT82DOdoTXwGs6BTu6xOkbbf3FZ/GnnSmOFJGLJWzaWKP+MMXtMmlGz1K6+
	eygR7ohith/nepcgrFSJz0tI9Hpbbn3f21js01LxLZb6RJiUjczrpTLirEP/d31fGK9Tbb29yYs
	QEm1OFyNhq9ZO7cP/+BUc9HU76ohNtDX8fdlwcxFk0mMq6SJZNY8vAWbKGPHqwE13L5DzjPUH9u
	qP8iXBiP6SLF2Yl5ayqGQa0e7IfTT8JexBF6l73V27Dlw7zt/T6s5DJf03JdFV3Rwq4v02j9CAt
	zpodMs0aNu82K7mx2SeOtWaOsm4H+1m3uz+G7z212kMyhHhppv2d7NY/b1E2N/eLb5jfnB84+7U
	vyyscMZCN8+TiQf5zaWAhWU6XPmeufCBer4I4rnbbFXUtbIKH/IICpU7jdAodQxZ/+1GsObZXJa
	k18VuKiDMepIEWQv3LV/h92mGWNkMq
X-Received: by 2002:a05:6214:2f0a:b0:8bd:de6d:c332 with SMTP id 6a1803df08f44-8bdde6dc70amr99892156d6.19.1778231826116;
        Fri, 08 May 2026 02:17:06 -0700 (PDT)
Received: from localhost ([185.141.119.51])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf39c81ffbsm12490036d6.30.2026.05.08.02.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:17:04 -0700 (PDT)
Date: Fri, 8 May 2026 12:16:59 +0300
From: Dan Carpenter <error27@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: backend: make sure to NULL terminate stack buffer
Message-ID: <af2qC62lFZMgu7Oq@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Nuno Sá,

Commit 035b4989211d ("iio: backend: make sure to NULL terminate stack
buffer") from Feb 18, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/iio/industrialio-backend.c:162 iio_backend_debugfs_write_reg()
	warn: 'rc' not checked for partial writes

drivers/iio/industrialio-backend.c
    149 static ssize_t iio_backend_debugfs_write_reg(struct file *file,
    150                                              const char __user *userbuf,
    151                                              size_t count, loff_t *ppos)
    152 {
    153         struct iio_backend *back = file->private_data;
    154         unsigned int val;
    155         char buf[80];
    156         ssize_t rc;
    157         int ret;
    158 
    159         if (count >= sizeof(buf))
    160                 return -ENOSPC;
    161 
--> 162         rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
    163         if (rc < 0)
    164                 return rc;
    165 
    166         buf[rc] = '\0';

If *ppos is not zero, then the first bytes of buf[] are uninitialized.

The simple_write_to_buffer() function is badly named.  It should really
only be used in situations where it makes sense to split the a big write
into multiple writes.  This should instead just be:

	if (copy_from_user(buf, userbuf, count))
		return -EFAULT;

	buf[count] = '\0';

    167 
    168         ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
    169 
    170         switch (ret) {
    171         case 1:
    172                 return count;
    173         case 2:
    174                 ret = iio_backend_op_call(back, debugfs_reg_access,
    175                                           back->cached_reg_addr, val, NULL);
    176                 if (ret)
    177                         return ret;
    178                 return count;
    179         default:
    180                 return -EINVAL;
    181         }
    182 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
