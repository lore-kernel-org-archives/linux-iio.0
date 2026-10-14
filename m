Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E6248551B
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007181; cv=none; b=XaM79rf5KyHAkkamPLZOTAmu1Ch1pNWTMn7IX4R8uUOMI6zPPdR6VXvUqjeyumg6x6QD8TX0WmtZi+AAq3s8ScsKo7oteLk6QWR4j8ijutlHe8DLxgQXsKDdUrIcKPibRnNttRKEj8M516m0cbrL5Jtac9HAIT0eFcQFtvfitAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007181; c=relaxed/simple;
	bh=yDFwglLcn+Et0o475/lV2WZBBgW6lHLcNPBxxjrCQrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHu+DKSHXnN5GWn7Hk0Ze3nCLARzbgS7hf+qxSo+IDq4SPLRDxCqGY09S24RFXa9C1HrWTS0eZ3AtWQ0hcXUG6+odbZzo4zQkwabnmr9XCdF0uMPp2uvqf/tr06G285oQt49IOP4K6WJwNdgs+XOp/vPxLGzsIsRNl9CbrZoFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=abqkm85A; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="abqkm85A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792007176; bh=LlsN9iNWBETqK/lTYo54mWuOREfl0PggeOoUj9EqgjU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=abqkm85Ahz5l5hQBBPsrs3nKhrTYoan8b0rum1VBxg0KTA80hvURNYyyKhCSH1fq7ZqAuAwGCAw6JUy3l7XKg25Qg9pwuabUxQPNfdRkezXKI1hwvH+a+TY/MxaG7KfXX/7BFLrRLwaNW1Cf3A0LZqEECvspeNPtOOPcXdxLzP+SgfIRY5rdzCqp/BnHSEy1Pa+y2Gl+0ry8f2r1X+YTdnMH4klxcinEKvzDyfu8aeEDZ/9tf+E+RZBZuc9F1JAEVkQvEfb0ls4Rp8LvY3RvLBdK+S2pEk1M9tiTMgzOn3zVQcRGtSDl/A/8ptQDgP7wtFBEShA/zSfJo100GA+h7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792007176; bh=1KHDJXsJi2ykJLKh78TaTeW3wHPxU0rcZA+0v2tAEcf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Nba7pf3+s/+4VlfCpmUTc2qP23qLEXX7bAXR3CWNhYbTqY7wP8kXK7M+H3gTKIxOlYLGCU9U6s8BLLigZfUoPPUP3U2B3puJhvv6SCBIGN9A0r2OrJFB9PGHYlCZVXmn+ICAGEU4IyxOjsMxPE8OPnbLJpWtIsRl5hcDN71udHoueyj9DNYkxBxiljUoNH9i5i4TLcCe4Nv9LfuwGFDUqYEZ5oHB4/Q8L0JURTgYcVfmz4dAAajRfIOwWrPVLWvr80LbbcBdevFgegbdCfnpmCEeVnqe92rrOJtA56eh5LGP+zfqvXIdaq6xmQDmtt55s7YGp0axbfP6zmuC8z0xIg==
X-YMail-OSG: 0IS2NakVM1lJ9u_yGlzetUUb8zMb3Ev287e8UcsEDESCCZVhgUbK.olSf1FcpSh
 XEtUXqHr3lJ0zLLhRxM792pNJIpGIT29J4yK6AWOnI_6bdF8OEkULskFGycEr5NBqCgPlLhvRsZm
 RhCAzG.z0LASvyNGR3uzbgLYak38JXTcyFq6a6znPWGwiL6KJNPxPlh3aLVIsEYtRYgkCaT8nsFn
 JeJXHeICbhA59zuAON86bAkhJldL6nyZUPNI.BNrbmEfjq7Em8EiwpSPU94UZMET.MgfmHcb8DqH
 O4bgdrw.RAV2Rv0UP_vk040BiV5b.ZOj1Ex9s9DOpiFp5LyqobcPIg8VtEyp.r.7l5zEb6ff_xc6
 wczPXCX8jGTF200MZXb4Hu4Sj_g2.Z.eoMQGe3UKy6rUkzvdwfXzdvJ30Lnx3PB.f0kKrQwebeHp
 Lc96w3yx6XspbQj0C26uqQB5eSj3qh7nFIVc6pMBvW836y0.vlOtvNN1eaooRsV1TjW5R2s6A6x6
 aGvsbnjJFIH0hnOfD.f2G.Vj.G2TDBC3YBumfeVuADzdbp5glu86CQOMz4Jcagp1PHZXP9OE5snc
 jUKynXUHCtcOQNLZERr1no8hi0i0kK0ff1y_fbhk3qb352m6XnqtjDcb0IUGUnyFzsz6c18Xxich
 Uq2AbmZcgZflqdDmD3Jk.QatrqoA0Bu5N6pNR4hRuTh0ci_BkXCEWXl7otclF6iKyAkt1FEJGESn
 P7DxbpOd.kDLA9x_jNO6Cor6Ku.Fb5UajmqQGiHztmxy5UAldbxG8xwI9WM5eb1sdgoPjUxPBewO
 PXDvm4ZOn.v9E3NPkF55ShwrW8YiqoK7ZymMnX3s.Fe_Atz296RbjLshf5qkzOI5Ba4pwyTbByre
 aMYDWEgDuE.bCyd6hAUx.mDwTsAgDhcsgamGbEKVN5wn.oufAu2ee4DFrZiH6x0lUNtte01AOUtf
 kWD3lyYRVFOTKQPkBCCKqJ.tdGdxQ6u4_poMd8Q4vSxAwPllVov7kOzrpri2XN.hIKix..o9YZsY
 SVqKSYJW7Hv6BmF23YmbX8lS7GQkBdlh.toyrxzBW0BENl5_CT1Wsp9BlQQFTe865oW46.ffMNYf
 pY_qvxy18S_IZquqr_ygDDQPltMkNkBslI7VrSG6Z_E9fH4Hylc_VTQJJ3_VQXu1KHy3pDzvu2MC
 QnZyfHacU87JAFmnYh6XsA1lrB.Cwcw3ZsqDGEJ8vNlS4X.Q.RRr4jn9PU3LlDQDN8lY1bGqeocI
 OTP9RMoYgYl_8h9M0uRYzERjIYWQItegMfmOtCH3SNdrI1xh7cRHDC0Op8FmvDDS6.aR6.y4QwmG
 tOUTN7yiq2ZYgqMQfpZLUiF5Bp5E0l9ny_cRpUl1RLykyeELwTx1hLCi3RDdZmNUdYdlO0OtKHYF
 Q8fNmS1JXcMUWpKInMmvx5UVSs50A6PoSjdWzsQj57xV4coNs2YaRiOr3uJM7wEawIpC1oWJQx90
 AJp0_tULHCQth8ParCxMt2W.6.VWM3lI5ht.J_DlGloSKdt1fxqK.MHu6rRgHHeWtMp_2U4ISy26
 AsKzeIDeP8nzhZxn56j9CqhyiqH0RVQOMbbWjAthUXXhf5_Gkgrdw9IQ2wZSNA8UMWlJOmgbEUxg
 qlHy_.9YDhwv131uGlGfptP.BN.ZmbPf..GT0OGm7Pu9.udphIIi3EqbqJ7k7ul5G5tkreia8QUc
 pekTUm.8xh3eAqFkxZ0TVbbkLi_a1nccxJ2PTxTYbgXYFkSk7l1t.B.jrr8rer04Raw_Zxp23XuR
 EEuXXkpENU_6BvuDzuN0AEcf85vqL93d9gbqKMfYd_S5dj1Lz5gEgidbYosZsCs7X0F7a8ELzk9z
 dpxBr4g45S10DoL9laa13_OuE7WkaJ14QXjblSXl2foRAAyqhfcytqBFsFK5TKrHjkaqXfJnpUrw
 FZ6ExKy4ggPZRAt94PGHEYy1Qukv3qH1.DorEe6cnIMSGf_ps9CgVK.mHL.x5EkcHTYSaesOdtEe
 wS_xkmLfYQ5xFP1t5EkOF7PUlwU8ebQwPZXDaNJkTdVmR
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 146d13c2-cb13-499e-9a21-220dc14a804f
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Wed, 14 Oct 2026 19:46:16 +0000
Received: from dip31.lsn.bf1.yahoo.com ([67.195.177.40])
          by hello (SMTP) with SMTP ID 34d3f16bea1af7245a4043044686d416;
          Wed, 14 Oct 2026 19:46:10 +0000 (UTC)
From: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.abubakar365@yahoo.com
Subject: Re: [PATCH v6 2/2] iio: pressure: add Sensirion SDP31 driver
Date: Thu, 15 Oct 2026 00:45:44 +0500
Message-ID: <20261014194544.2705-1-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <asz4O0zceqa5lz8m@debian-BULLSEYE-live-builder-AMD64>
References: <asz4O0zceqa5lz8m@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 Oct 2026 12:09:47 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> > +	indio_dev->name = "sdp31";
> Hmm, I'm not sure whether it is a big deal or not but, the hardcoded name might
> cause confusion if the part connected is sdp32 or sdp33. [...]
> The full disambiguation solution would probably be to read the product
> identifier bits and match those against a table of supported devices.

Hi Marcelo,

Thanks for taking a look, and good point.

I kept the name hardcoded because, after Conor's comment on v4, the SDP32
and SDP33 use sensirion,sdp31 as a fallback compatible, the way the sdp510
does with the sdp500 driver. You're right that it isn't quite the same
situation, though: the sdp500 and sdp510 are identical, while the SDP3x
parts differ in range. The readings are still correct, since the scale is
read from the sensor at probe, but the name would always say "sdp31".

Reading the product identifier at probe and taking the name from a small
chip_info table would fix that, and I'm happy to do it in a v7. Jonathan,
would you prefer that, or is the current approach fine?

Thanks,
Muhammad
