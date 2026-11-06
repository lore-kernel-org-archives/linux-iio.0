Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986910;
	b=Bqxx4eQolUJhTCYau71yDyT2ORHtjF+2VXmAKRVkUbD5CknkbJkrQ23ieK5eAMZxKVJ6
	 yjLmNVkEAEeOz1IEHYEaX4LFokBni03I1QAHOD3IORTGB7Lb6cs3kpoP/btFUuXHm7ICT
	 TSjD9+XoxiWsvxoUMYePhj443kTNBrwK3Ks+mMHnkF8+G4StHK5lZyjS9iUVUJZk27R7S
	 xRCWhEmDVCOLws+TiizKR9K1QteXZL2Eb8G6QKULJHRy00597f033FAAwq4X6SXjZufYz
	 7voqW2oU1xApcC67y1xETjtIw6FT/seY5SqWGanrjyY8IYc6pliFi+AXIA1iQPYaJ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=NbvnOhYR3ZfcLZphPp6VAqzXuqxR3rkqGX+oafzOp3g=;
	b=sTsJxBIxt2s1kQQbD1Off+Zf2FsMpiBS0AUlt1Mq1q30tzgVapxs6PkqeaLz92R7lPCI
	 slCWoHnjqkIsNl3fCewTI+ybKus3nPgrcImRlOabc5tOSL1iXW29umTy46UTDpfkif9yJ
	 zys9XyjOCZrkLjuAKM7TFIztNDUat2UQuJqc7oLECavFFrmTMulc+gn3rXrNkX9OyXa9u
	 bDESpmpy2teFeKRV5z/pZEcDPIM/vHkpKQBC2ACpYEDIIreQu9F2rRh/SaaNRe+cl6VHZ
	 UfmyaLZrn7YJuTCRlwhNDxfFCS7sypEuUmR6a7L1VFAXZwEq24hMRec9RN4Qwp8G46Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sgsatyam.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cnlwgDlz;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC9606A335
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 17:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0EC9606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sgsatyam.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cnlwgDlz
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea63087d79so9188905ad.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 09:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793986909; x=1794591709; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbvnOhYR3ZfcLZphPp6VAqzXuqxR3rkqGX+oafzOp3g=;
        b=cnlwgDlzU1lWqDXCYRUfzFw+0Yb74ZTl+REefg7lcvHxNCpVZteWyaChywzWRuKlJQ
         +AoTBakvnTsfnRT4Z/uICZ8tUU0RlvNM2t2PDVGuNgwTrB6mO7aRHSY/9hC0+n2W5ALw
         obwKmsL5l5G1gwi+s/vCXQjVjWu0p2be8uPqw8efFaRBLcCMtmt0pa2mFGyCZJWDxhwu
         HNtaciIFu0ce0b+cbU/2zdw9UQEb4O9Fb8s4tQ1zMYBXLq2wVTo4Os2b+EM4NFtQKz5Z
         uD6sNWr6qSnM9e1Mf8VDX5ZrVuRXVgFcYqPKX7FZah+AGHGuaAcc/tHRkImihzMudBvK
         E49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986909; x=1794591709;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbvnOhYR3ZfcLZphPp6VAqzXuqxR3rkqGX+oafzOp3g=;
        b=HBEfqu1DkiH+Z7bxzA/B/bsO/gkg5BnpWTHNPrKZ/jrbH1/Zt0ejuLBbGh41lBg6tX
         LjVjkEfS0wF1xlGLRYSjE9+R5C3//DIAkLUVUMFoqMMlcOsVyTgPfGsLN+0Cj8m5eiGl
         C2/g8JmpL6r2kbYPkvlGD/xI/uzbblA7PG35S4mjjpWzMPLT1djQ5mUH7hxMi/ilCjsq
         IWoe7lKciu2KAvjDMfvW5N6cHG3fPbbl2aZ2rqZKuLuNXHpppnuHNizNsucfaLzpMI5w
         /Pgu6Xkb5Eif39K1cZipcj10H3W79ZkGXYjIZabOGJz1SQCHrGuTFdZjH974aul3+D6y
         6nzQ==
X-Forwarded-Encrypted: i=1; AL+hErF1H+eZ25l8ulkKj+xARKWZkuXzaRXQcpE06nO1GShxanuUxjrQjVfxBlFQirfIRvly1s3FR2kBUi8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9n+m+2t2Lm1rnTlp9OyZDtrMPeb7BWf9n2423Md8krlAMKs771
	xFkGgSe3uU86aNBboI9paa1jnctWqc3bnXQ38TMlv7No5P3bBzd7iipyafbN4SD0KAOatsfswR7
	dOka6l09j2hAh+w==
X-Received: from plnu5.prod.google.com ([2002:a17:903:1a45:b0:2e1:326b:da73])
 (user=sgsatyam job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d58d:b0:2ed:128f:73fa with SMTP id d9443c01a7336-2ed40ddeb74mr41588915ad.46.1793986909095;
 Fri, 06 Nov 2026 09:41:49 -0800 (PST)
Date: Fri,  6 Nov 2026 17:41:47 +0000
In-Reply-To: <20261106102217.3bd67592@systembl0wer>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105073107.172121-1-sgsatyam@google.com> <20261105132057.2429385-1-sgsatyam@google.com>
 <au1FF5K9EALuqnNR@google.com> <20261106071904.142937-1-sgsatyam@google.com> <20261106102217.3bd67592@systembl0wer>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106174147.1351648-1-sgsatyam@google.com>
Subject: Re: [PATCH v3] iio: cros_ec: Use platform sensor_num to unregister
 FIFO callback
From: Satyam Gupta <sgsatyam@google.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Satyam Gupta <sgsatyam@google.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, "=?UTF-8?q?Nuno=20S=C3=A1?=" <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Enric Balletbo i Serra <eballetbo@kernel.org>, linux-iio@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 10:22:17 +0100, Joshua Crofts wrote:
> No, don't send a new version of a patch as a reply to the
> previous version, it may break tooling like b4 for example.

Got it, thanks for pointing that out. I will make sure future revisions
start a new thread instead of using --in-reply-to.

Thanks,
Satyam
