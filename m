Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769850;
	b=ntP5P/6ln9D5k+ARX5FweGaqzS1IKEzFkDckXqZv3AFIkt1efTsFhT0PPbq69av15vBr
	 OA67H67i1QrRoIcOL+UMcJniOxSxA+BpFmzXTaQqCnU7lMC+7IJrj+fVMi7vQUhPQWk7h
	 4fhedbtabszlZkI790tp7qeCQM6Cl7rzZyF0KeOLUxAI8fsSWyH3oZvXpakUVUx1wucps
	 bbm3O1CozcRCk6mjvCkQv04BK6QgJwU6eK2X+Rsiwb5mu+gAcm7DhGCqlbb1XdBH0hmOA
	 aKesmOdBfVQNGG0+3rdG50EgrqiRieiF83qbszAA47ZDK49gB0w/KGZLhu0QqLFdBiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8ZHPnS6NhQJdC/T3Sn9QKMPB5Jy2JtYiZNcejBPsLzI=;
	b=KHfKKUMr8SXaNXsG9Bo7yN7Oq3PJuC0BnDMN3TE7Jeub+f60HYGmdTOjZCuErmzBlKqc
	 jTZg5fOIjerl+MefAE5mVzrgbbvDytZWXO14hs4ThvSV7Wc41pAqOeZUlJdWT9qG5j7wx
	 DhLEcJghjpN9SvSnOKAwc7CzTvk5RGpivfAEogEfo6tBHxgT1aK2mR+xdhNB7wc29lG8P
	 mxHi7k6c25Hk8PEZ6iVA04pEcYo1Tazhvr5949tAob+GF+RKXnLROnXWlkQhPOjA1my4h
	 v7rMlN5BamYTowrv66gZ19Q+zs8BLXGAzP2FUfg3qSzRynYb/lSxBNc4WncAFt54yvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JPETXQgs;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484F606A324
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 08:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5484F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JPETXQgs
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-94961bfe1a0so498774585a.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 00:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769848; x=1796374648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ZHPnS6NhQJdC/T3Sn9QKMPB5Jy2JtYiZNcejBPsLzI=;
        b=JPETXQgsSYFXPTlEs2hMK5pnaKeTAgOSzwYiw62Hmv7uwffWA6lqQlwWDMjhBi8rHJ
         EZSwMJB+s/mQLoUB5nTiNQaK5EUPt+uCHl/7kw57Zw/IKQnmTzf8vqDohNxruRn2QWtf
         sF1st9ZweLPTzQ0GfLBrXSskm0YNBlu9iOz1+hWw5Kmnc+pFeQtwGToSx8f9Wdnez8lY
         78AjBM1Jxq7gzmlVenzJO3eHUTmCwoRJylmMIXT1VBaGgQGKDYaTz4dP+uFuPJyzqgDh
         7zA4t26HGQLZtmTB0SzYfrfidQUFqIsnJdn0KJNSiXntkNZOzS5LNQd3sJfkyYmOuWYJ
         9pTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769848; x=1796374648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ZHPnS6NhQJdC/T3Sn9QKMPB5Jy2JtYiZNcejBPsLzI=;
        b=uqGbf1EoeY//8B2P85LboI4dl+GZCITwqcxGxEwPUhAkKSuUT93XIOmE8VhpIXMkbH
         aIHG6JgtTrvyEwbgeT+lp5ObKGWk6rMSJDh4s3F9F3AwsJMiJrOvTy+qnJn1XcWe8sw4
         DHcKJQ2I/I9ic+tRVq1erFHr4LjAxygz6CGDBtX2VPeL+cfIfq8cWrjHPhtChOhBoCaS
         Bv+pyFV/g9NHr3RWGHZ9bR1Z99pAE6PkFicKvQquduDut5XQOskQ+CTI+mardo3ego2h
         IEalmUenDbBl433M0m4gusg7Z2uE8Nc4NzYMptd5QLAom2Jg6u2+e2ON1+sqoTXpWl+W
         I0OA==
X-Forwarded-Encrypted: i=1; AL+hErFLKS0n+axx9fr3YP7BpCAWMvwyFV2yansIDfiwkg+F9pWkSKKluj2MR0l+ZTTzf/FgsW04DwaT7jE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8krpw2EyJCoOIbQdVkNsrQ6cNVn5jagzCCwbwcigrsLfMr4l7
	3gboM3GFetkzlZ+126nm2mKsXMBn9E4TPaMOmeNIN6ix3yk6OIhOWZ32
X-Gm-Gg: AZFdTZecdcOnQbP7s+vuDEh+oL4vAeZrT5+kgWZniQJzLsjrOnqm53h8X+o0kcwWxpR
	/EU+oLM5R5aiX8Bx3RDdprUOpLR8RS2UvikCZawFonmSCLjr+Lp559x9HFHN2xJ3vH1CAIj2hrJ
	jreA9b94SnLwYw6c9Iy8094Xnvj/rVmmp3CI9Q2bnBpYNkiEKxR3kx8K4fhGmQS8BuBV0X8nt6k
	GTD++tiydJhWjyO0cBEw5wLrUr6ee7QRGM/z5910WkmFZElxTJ93SAGxIbUSC05C5Qbfayo6eMV
	G48212oyNPQqDB2+jtOwcSQ1AYIVYmqv9nea67OdWX96ECPAZUdIF7N+n1+szuG07xLYjMsjysx
	dGIBOqUgd++wHzAFlVc0/uHPEZK2Ev5ktfDX44z4l2Jg5xF/O4OxO3F1kcQjx0k62RCxidQ9asL
	GgPn1UXPCodtc8Cllku3o7dc7GjeObg+o/I4AlL0OCrq2BJxwYU+sTBpI4OT7tyo5oPsuEaEEuR
	lW96fD7Qu2Jrlg8GkInW+zDYEDJ2TkEzIdNL9EF0Qs1HTlVhid6HvblwwJUpc9eOtmfQCdiw3Ee
	5qvZEQfo6MnDIBtxgUmrxHVTSlC0i8/tcnw=
X-Received: by 2002:a05:620a:4543:b0:949:65fe:b727 with SMTP id af79cd13be357-949ba9b99a7mr4359649885a.26.1795769848210;
        Fri, 27 Nov 2026 00:57:28 -0800 (PST)
Received: from localhost ([2600:4808:5693:8201:394e:8b9f:994c:b59f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ae74sm1767085585a.8.2026.11.27.00.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:57:27 -0800 (PST)
From: Marco Chen <marcochen.dev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 1/2] tools: iio: iio_generic_buffer: return 0 on success
Date: Fri, 27 Nov 2026 03:57:21 -0500
Message-ID: <20261127085722.126797-2-marcochen.dev@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127085722.126797-1-marcochen.dev@gmail.com>
References: <20261127085722.126797-1-marcochen.dev@gmail.com>
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

A successful buffered capture exits with status 1. As a result, shell
scripts treat this as a failure. This happens because ret still
holds the return value of poll(), which is the number of ready file
descriptors, or in the case with the -e flag set, the return value of
write_sysfs_int().

Set ret to 0 after the capture loop and before the error label. The
read() error path currently breaks out of the loop and would fall
through to that line, so make it set ret to -errno and jump to the error
label instead, just like the poll() error path already does.

Fixes: 6bb7cac8551e ("tools:iio:generic_buffer: add error handling")
Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
---
The read() error path was found by inspection, but I did not actually
run or test this error path explicitly.
Thank you.

 tools/iio/iio_generic_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index fd955cf444ad..122fa54bb74a 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -807,7 +807,8 @@ int main(int argc, char **argv)
 				fprintf(stderr, "nothing available\n");
 				continue;
 			} else {
-				break;
+				ret = -errno;
+				goto error;
 			}
 		}
 		for (i = 0; i < read_size / scan_size; i++)
@@ -815,6 +816,7 @@ int main(int argc, char **argv)
 				     num_channels);
 	}
 
+	ret = 0;
 error:
 	cleanup();
 
-- 
2.56.1

