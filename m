Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610679;
	b=3d2TUnXfxBqeAOfJbzFuHkyGKojIBTnURgKgEmx0o8N0sSaKlUwxB0cDTdCIig7ckbYw
	 b+bF58PLK+hrdHbL+8rgQ0ai9yJQGgrUyQnZJrOT3fgTiiQH9cGkNDauz0VcLgc1PWW+p
	 w0X//b/1eoc7IE5ft7p+i9AaujUBVC6sMHbWOwjEtvy+o0QiBLUVRb5QoMOCYZE/hPloA
	 8MhJvKFqz9b6j4koFUwmU2VMsLywag0hZa2g9kA1Ib0JRWtB7FrcanI095FNjLVUurZUC
	 GI58V7yesUKG0AZdenJDCnuikFlWze9MJXVrixd5qNcgsp7UxBMjoq6uZ/Bh7lL8Nxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610679;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b+WKeq5+AMB5ERi4rfdmh8S8vs/usV+GK7ZBlaPdQlY=;
	b=My1+QflzoM5iNDDKgmnCFctp0SaHxQRmGfBJubPtP3TrPfiGdndzR6GubYNvC78MRj8R
	 rns5zO49mUK38KQSrdgYNKLCF/ZR2z5C+/kb0EbyKjh0goK7P5hwQPE8lU975BSnnTJjX
	 rkFp2I0YDAe6ThEbOYRPWKg1oDxKc6x9/z5hGSZ1e1IDg736HD6v57JJvI/E4OY8D+w9/
	 m2SZfPvJ9goZWAcJZv5iY1NR9TTJOlfXgA9yFivrKEyNnt3Ui8GxpAG0VnOp+h0CY2sI6
	 NLWOVfYM1F/aMB6umP7k1eKSBid9JkU3gcArqIKdkT1i5vkuD7EIfwyVsOcS0m/N5sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcfNXyY4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A62606A320;
	Wed, 21 Oct 2026 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcfNXyY4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04541F000C1;
	Wed, 21 Oct 2026 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792610678;
	bh=b+WKeq5+AMB5ERi4rfdmh8S8vs/usV+GK7ZBlaPdQlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gcfNXyY4ZizdPocCqPHm3/oMOnsISZfhFts0SZgim2bOxAeo/C2Okc7ka978tS5Jk
	 mO3+NWwbP9vYTP+onXAbz+DIVIEW7+zaZP30oici90uApWG5QE22NqKBQ7iYC197Nx
	 tb9y3ntJUR8+jEVMM6E/XsNHRWe+n7pIZ6RvtxBzJ9TjZS6NF1rcTIeVnFAxJ6m7fW
	 g3yYwGIX74ctfoTeBffHsU4xdyXKZ8cM4U5V58hpqJitwdsTDgNW7D6uX2FKv5bXP+
	 0gZhMyMNFHMk54cuTTtp2G8gcbgpeOl79HOFhoLGLsxj0df0FH8MB5kpLd6JDAzb80
	 +jCLlKeyQB/Wg==
Date: Wed, 21 Oct 2026 20:24:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Marco Elver <elver@google.com>,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations
 on mutex helpers
Message-ID: <20261021202433.0efc7979@jic23-hlaptop>
In-Reply-To: <20261021181944.14272-1-zoone.rupert@gmail.com>
References: <20261021052435.112686-1-zoone.rupert@gmail.com>
	<3f41338e-fc47-4306-b68b-5a81c26027fe@acm.org>
	<20261021181944.14272-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 21:19:44 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Wed, Oct 21, 2026 at 08:15:20AM -0700, Bart Van Assche wrote:
> > Why doesn't this patch set CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y?
> > Shouldn't that change be included in this patch?  
> 
> Fair point, without it nothing checks these annotations. v3 will enable
> it as a separate patch, so the fix can still be backported on its own.

I think it's unlikely an generic subsystem wide (or broader)
enablement of this will get back ported, so instead
let us treat this as a forwards looking move.
Drop the fixes tag and perhaps include a second patch enabling
the context analysis much more broadly.

I haven't tried yet, but I think you said not much broke?

Jonathan
