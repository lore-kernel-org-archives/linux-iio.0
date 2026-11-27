Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769851;
	b=rbqd6TeQS+1YAk+L/N0EUmNZYSBCNZ37W577O4iv6sGoUrDHBcHzWknjH51vAxebTxKW
	 rLGnUdavXCuCOdalwy4iVi3DJbNiOBgEW514rv+fqW5Ra5Aw4r1wTybLIIbtkWfd+/FP+
	 U9IDeg6+hCUw45UMg74lkSo29fvkH/Kk3aD1pE/SW3lX3dlGpCgpQRJ2fUQZIK00lp+79
	 awhZ7XeLia1k296ymDO8Fx0O0Vv9jQpSZe+Uk1yKGLTN/j4yxIedHbBaCrkGhDaBbEppn
	 0TcJNO/TG0SVKC6oGXmXw+Vz2hA1I39xjlqqSdY7BrqLSTVGFqjSXWN2pnEpyWkXvrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D3BUd04JVrnXcutr4tZgrlnJxoE4YwrhlZjXYG1JjPI=;
	b=28EPL6yLvf1jF4tNQvAjWGr3EzJiKAHmAzLi/J7lvSigo7ZttXy/0j+nVlWIcnzSQTy+
	 sX3s9Sx40Dx25P0kkpxO4d/WawSAaeUBh6tzeajRZdCTMNY5BCKGaUkwkTY00LsfX0pmQ
	 hk/+65c/aoWh0j+zP8+K0iTuByN9oNn6ayCNPT/lMGk30OzAR+YlDKN4Gd5SrLNDJ6VcA
	 5fHnxyM5la6Wf9SQrRxhMnAJE5cWzklBdp8uJmJgzXs9KCuN5grQYErhskNIGvc0OcjUK
	 L7LIgFDtNHl3b4aUdtOw5Cm7zz9I2P56iA3zsvDtGq7QC1ddWXUSyDSc9kUQidN3UHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vpdLxUaS;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DA606A326
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 08:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D81DA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vpdLxUaS
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55d2f5f1e26so85437391cf.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 00:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769850; x=1796374650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3BUd04JVrnXcutr4tZgrlnJxoE4YwrhlZjXYG1JjPI=;
        b=vpdLxUaSYP7rNZtiUbFpSB9+7xnHucpy9v2kjqm3oXTDcc7fOyKlI4y+fTNGibE+3s
         df5h3iDcazeDTf4nnBvEaUjkh36FifZyshrutwOufUzKTPZRjemZvpC97m1yKQYSBQzQ
         8oOKecKf7kOEZ0exwYpTTrfI1N9BpV3cH6w25jV5DQGEagbO/R9iYwQ2iM0LgD7X8Wny
         ORR4D5VDN0oia59y7Ga3iWprp2h4+wqyPfcORUuxj72e3ownH6Kdc2HJJitjAR69ZvtN
         bHcJ2IxS9HiyG7HnuxACGjeeTSJDtNEzPguQHTfYBK10TroAZGKXPIM7Z8dXaO0ys3x8
         ecBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769850; x=1796374650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D3BUd04JVrnXcutr4tZgrlnJxoE4YwrhlZjXYG1JjPI=;
        b=c0PVBS5Z6P6sjl7BrMZeRZgAvkYptpm02VKh44yghsQ00EB9mUDh/ZPgNoyW4r22UG
         zCgsUGRY0wIXjvC7wDzcY+1nj32542YJAOpyAAvVsOjww5gpMzPO5hFvlICjSOAZqkKc
         jasIyn432S5XkPhJZ9cc/khAEqEeT09qwom9nDFRPnyhhzMDkiRTf8iXDEGHzp6njzrO
         MmIgNmOqE+nqGeeiQ3bbuxPhRk91IM4M3W7pq0ozYe2RQi7JhRgEMtyvHN2nk9/VP+Kv
         qtzAVNaDA49CdzpWWOXG9ByrJRb3QSYIgueXB3BHLpB4yQIrTMsSkoGFb7gy7huMRjPN
         Pt+Q==
X-Forwarded-Encrypted: i=1; AL+hErGfQW8+eWjtgCPSxHmHO7eoS3ZR5Wp/3SLB7ZvgNt2zvBFarXr+WpvZrHih4AqYvsazdNvxlbokuAw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Znwq20mQAKg96QINNZIapXKoIUfPW5RFMvxECZmFhC2vg5KzN
	UN+hXLhUPYpgN31lNx1YfgJtSpfPbS/OElJghxDsz2OHksjfuOPNCox6
X-Gm-Gg: AZFdTZc6fPjS4RROWYQckg3uJqWft3Gdv+Aj761RAKFjbxG2Y9gRsm3pee6rslgiO6G
	+8khVPB5r+WepVad9Bi5WcBwNR2QgYq/pjvaTVI4DDkI9xS9bxG+NsKl4WNzHLrTyv182y4mAh9
	+0HLkqyeczlumoQJe58wZ6Ebd+WW8h2r1szVFN93P6luCIlDeuu7S4CfhjzrBekpfF87su5fmbU
	WxQOFVcB+JVm58qhHynSuz6tIAkB1O6L7ZeVEEdj50gBINDc3s1hZp6VBXoSLJcArkyfiX6egFS
	7OM5EMSZM2BvCHDQHc/wPlbFuCD6UL2hZtWocVe2zeeePM+D2qTPXZCsUdy6x6VXmpuzIgT8Y0J
	xz/u23xtDtNpIiE4zXcYoX4w/rUDwT1wgXTabod3n24Gm5THh3FBwTIJuR7/Rn/GFEnT/80xcBu
	qBJRwS26E0x4HCBeDpBSLijiilhW0L85SXk0TT7/GDJt6tx6l3d1Xfl7KyQDcd2fn6c+kbIOKPt
	fY0rwis4ltqUaZ6mBggvHr42d7f+mgvMerhqmMpJzupB/yx3DcPEG/cI+04nZWifbt2wgnNigsK
	6qI7wQ4L/DLY7ds3iS9gFC75D+i4js8oleg=
X-Received: by 2002:a05:622a:1909:b0:55c:840:1307 with SMTP id d75a77b69052e-55d76a2609fmr418679661cf.20.1795769849822;
        Fri, 27 Nov 2026 00:57:29 -0800 (PST)
Received: from localhost ([2600:4808:5693:8201:394e:8b9f:994c:b59f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882ea2dsm203415471cf.15.2026.11.27.00.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:57:29 -0800 (PST)
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
Subject: [PATCH 2/2] tools: iio: iio_generic_buffer: return error if no channels can be enabled
Date: Fri, 27 Nov 2026 03:57:22 -0500
Message-ID: <20261127085722.126797-3-marcochen.dev@gmail.com>
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

If no channels end up being enabled when using the -a flag,
iio_generic_buffer prints "Still no channels after auto-enabling, giving
up". However, it exits with status 0 because ret still holds 0 from
the preceding build_channel_array() call, so callers see success even
though no data was captured. This happens, for example, when
iio_generic_buffer runs without permission to write to the scan element
enable files.

Set ret=-ENOENT before jumping to the error label. This fix matches the
"No channels are enabled" error directly below, which already returns
-ENOENT.

Fixes: 5f991a921a08 ("iio: tools: generic_buffer: auto-enable channels")
Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
---
I used -ENOENT to match the existing "No channels are enabled" path,
but I am not 100% sure if this is the right error code to return here. 
I would be glad to hear your input on this.
Thank you.

 tools/iio/iio_generic_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 122fa54bb74a..974548150eb1 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -643,6 +643,7 @@ int main(int argc, char **argv)
 		if (!num_channels) {
 			fprintf(stderr, "Still no channels after "
 				"auto-enabling, giving up\n");
+			ret = -ENOENT;
 			goto error;
 		}
 	}
-- 
2.56.1

