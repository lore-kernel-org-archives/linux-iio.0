Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794986999;
	b=g7875/v8KvvVhGZMG7ej8h3Xg3gVpqBk57Ih6kKr6NRlDBDdQze0IyhZ69rSB6apf+3l
	 JsMxoImmnBaYz4Famt0sw4vYXQ/k/e50s+8zzTr4G4sb+vf6+s6dm9QhhZzlj0aQYoANP
	 ge8RSgAU0L7ignzNelV/zjXtpGiXjMey5/ADaKztvU/w83VPuNRrHNiS6S5qbNn3BN4SC
	 IME7ALtZg8JsYCDyF5bRq3TvE7TEvzowfMvgj+YLTRSVoRqZhOSf8COuwHJoMOySNJsIJ
	 8F23296rjlYTOkb0M2CCzqppEGtxI/OSw16jsVTNc3rAjuHgRW2iKTR15eOttVW4EXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986999;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=8pAcxWfno/7/g7pSv79K8iAv+1vskTE6m/4qAyuVt5Y=;
	b=GqXWqdxnw9bRzMp8sylOQGpHfCf1kA/reXdGweE56KFV/tWRl8kPLH7VHpYCCRyFCHiz
	 1p4ihMaYT/B/0PFQEgfJk7eSext4Pqz31sP72dEluofurkrxtIYp+0HCX6gwQ6RDmDubZ
	 9kFs7vOxoHIzPHJmL0n9uknorsxSlSonWajaALTj18/sZOxiThg9rEXLnl80HMtyyQQrY
	 zwngCEP2QE/SxdmogzI0fYMtLWiWrbi1k8qeylnq+xIzyabTlRI3czLWVrI0xn4dIre4X
	 seqsBw67a3rO9Cy11XjxVYK8EHkfvAXio3+nadfCiwfSw+iyUFhn4NfV6irRIX1aOWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BB98MlFP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE3606A31C;
	Wed, 18 Nov 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BB98MlFP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794986998;
	b=FnjptiHKVk4FqRefdUK7YaV7qlq4TAnetF6MQ5I6J/Uiqo5sz1hsNPaC0ddPuKItgTfa
	 K0gepVIM+l3gz8TT8b6NNhnSY8WhuDxknUMurQjyRAePADjF7vMgtrZqxNRhmQGnMeTkO
	 e2PKyN/VSJXrucK+6v1cRpoePiaqWW1V5gy1izSYue4vbe6DeXST1Lcz9LqDswAnf+pGr
	 5brWFeKyRyMiy/Jbs4QKAh2jbBFz3BSRqx3Nfnwzavxl/5P2j/gT9cFts8U8FXvI6gs/V
	 TJGYlZgL0aib/I/8r26kghmw1n8kWRv+hB6zO9DMyhvxXb/1V5SjfV4gT/BdNShrw+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794986998;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=8pAcxWfno/7/g7pSv79K8iAv+1vskTE6m/4qAyuVt5Y=;
	b=YHylD5TdY56kFJbhuvsxm3xY6slxoCxF90TsMWD7nE6zSeRezps0Q65w/hs1FqbuGbGs
	 mv4IdAPepu+zQwwJlMhUbhn6N25oQlDTJWKvD4FG/qixYP4RwJV3Zm1lGWoGQraWhAo4t
	 7PqLd0tKS0r74m3zw3OvnaB6c1SJKW4vyuEh/0MGHz3vEEwU1R69hOKPRWONd5OLKCesu
	 SAi7KZGdu4GDcGCkWiWijq7AzVyY0w6piG/3Cp8tjtDPXH/qmi+ULr+zOODU0UVMaJNtA
	 2ZTZzYvOZR+uYX+XO3iexcEbd9BskURymNoJ+0cDiJFypgimJd7R1UJkdV4EhordCQQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6B9711F000C4;
	Wed, 18 Nov 2026 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794986998;
	bh=8pAcxWfno/7/g7pSv79K8iAv+1vskTE6m/4qAyuVt5Y=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=BB98MlFPE2b5lxTwH6Nq8HMcuGRLyll2iUyQCml0MMeJGHYeYMFxy6vm/5sR+dhfJ
	 +NM5GrdTJ9uwIXpP2dwne4T32aZHvyZd4gpuxn6RQ+SDtF75fDfta3/yYXxfJT+Iae
	 OSGtbLchWWy37aM5to5ADmb07NeH/bHHX9grV4D2pCEWhCqhfm5YYoET0tJlhNdY//
	 270EQ3b2rWyO3KxlgbqNPpT2TFvK2Z/xayiKivV1Tyiu8e8PlMLe7wK3kN2e9oY913
	 UsHIvHIK4/71lEnhq+lS2QRFohkb5E33d4Rrs0TzU05zR+STmvjTMkPwPNQQYfWqco
	 3IsmfKmNI/T6Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DF13E4AC48;
	Wed, 18 Nov 2026 07:29:57 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] iio: light: adux1020: guard() conversion and
 follow-up cleanup
Date: Wed, 18 Nov 2026 07:29:53 +0000
Message-Id: <20261118-adux1020-guard-v3-0-2c6a18954fc7@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBQFr0K6tua3oG1deQ/jorQfqBEwLTQYw
 t2luCExLid5M28mAb3DQC7ZTDxGF1zfrZAfMmIa3dVInV2ZcOBnxkBSbceJAQdaj9pbmksOBoU
 qZJGTVXp5rNy0BW/3L4exfKAZUiUtGheG3r+3x8jS7m88MsqoLZU5SV4xRH2tW+2eR9O3JMUj3
 +lM/OicApVKgKg0CDBqry/L8gE3ffc7/QAAAA==
X-Change-ID: 20261108-adux1020-guard-3820ce794843
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>, 
 Joshua Crofts <crofts@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794986997; l=1839;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=RXUFbqMqVQo9jZv0Us7HCxZkFucYXq5iLDMq628Oc0k=;
 b=nxO0SD52gnUGe73c9OUMJStq8JsN9On8kXyP7UxtGE8EFxtrSqvl/0OeZxnloSAemDwHs1O+6
 tgKzkORU2NFAOeQUAdtbbu5vySThxbBjygb+90ItmeVW6VuM0UCRexh
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com

Patch 1 converts the driver to guard(mutex), as Jonathan suggested
when applying the sampling frequency hardening patch. Patch 2 uses the
direct returns this allows to flatten the channel type checks in
adux1020_read_raw() and adux1020_write_raw().

Tested on arm64 QEMU with i2c-stub and lockdep enabled: reading and
writing the sampling frequency (valid and invalid values), reading the
LED current, reading in_proximity_raw and enabling the threshold
event. No lockdep warnings and no hangs after the error paths.

I prepared these patches with the help of an AI coding assistant, and
reviewed and tested them myself.

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
Changes in v3:
- Patch 2: add a local regmap pointer in adux1020_read_raw() and
  adux1020_write_raw(), and use 'if (ret)' for regmap_read() errors
  (Andy)
- Patch 2: split the adux1020_find_index() arguments logically (Andy)
- Link to v2: https://patch.msgid.link/20261117-adux1020-guard-v2-0-89707fa070c9@gmail.com

Changes in v2:
- Drop the unreferenced Link tag (Andy)
- Move ret to the end of the declarations in adux1020_read_raw() (Andy)
- New patch 2: return early on unsupported channel types instead of
  nesting (Jonathan)
- Link to v1: https://patch.msgid.link/20261108-adux1020-guard-v1-1-db9c582f1eea@gmail.com

---
Raffaele Tranfaglia (2):
      iio: light: adux1020: use guard() to simplify lock handling
      iio: light: adux1020: return early on unsupported channel types

 drivers/iio/light/adux1020.c | 189 ++++++++++++++++++-------------------------
 1 file changed, 77 insertions(+), 112 deletions(-)
---
base-commit: d922ed738439e1d5b4701df7f4cdd49a09925624
change-id: 20261108-adux1020-guard-3820ce794843

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


