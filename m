Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC02348C4B
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789302811; cv=none; b=b5x+dBxQnjH4rXATHaWMruv5tsn2pfZaxadVedTXwh8yhZT2SvkGI73PMoa7i1p1+rxfiAReqmHFOIDdA6994SK3d6zq6D8ozXat1sgKMNvo0ugCKH+GYueSOXmgaT6iq9ENwLxLfz2eNKA6uvNIENCZaPWQvXvpnZOTvax2ILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789302811; c=relaxed/simple;
	bh=RDT/FtmmxZyyNNUPEXNnhj1vIFsc1L6907cBrb+t5no=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8tkihFJzRV4koBN/dICgDHz9kbZLgxzjFaLnlryOTZVK11w2K1PtEAWBDUP/VBulA61SNSV+WCfHtC0EnWCIHMaHveSc2FvkFNhvKr1JzQMVizTUExfzmtbGxScr4djj797zdr+b/IsmJutIJicOXDPnj/R0FMKMATfIBGvyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ShER0QOz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N4FlcUvm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ShER0QOz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N4FlcUvm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DAU2WR2053458
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 12:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wocl7fHC8i0z+n+tlMoixJLCrrcWhEe8daP
	4QAajZFw=; b=ShER0QOzIjSdvdy+teTcv95CM/vgBrPrYMKP7927JEbjODw7dZ5
	Otg8UC1IWmsUbJ+/pD6h7F9yMOHhe7luEMLYAvlB2IkRr1gT2xaOZscummQzb5Lb
	c7/RtdzKtTkIP/Edck7wjsO/F7471YdmHElMVmpT74GiD8SHKqF5uHdNcIimydT/
	52U5Wk7VmyDY2dmRpFUP6OHeRdD43LDnI9Ytp+u8dfjRvd1R0I3+BVa7VW/2pipM
	eHqlG2BsNnYUwP59AU0Vy8pEaXsLaA8xu/T+txu6pd3kqrpxVGqrXIm760p+LMRW
	cWR1i30CQv80LwnUcv9az+TXI7MkGFXw7tg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dk7j2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 12:33:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a1bffc2eeso83605185a.2
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789302805; x=1789907605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wocl7fHC8i0z+n+tlMoixJLCrrcWhEe8daP4QAajZFw=;
        b=N4FlcUvmniarKidYLaAKytvy7niogqbtIJ3VOZZ9C8dxa0eBL6SpNrMF9SKKDGrBfG
         ZkfTp4UKV+vYfBcwTFfPCwlfdkW+k20Z/Rno46Xsa8KGSPMOIovN6txElhbMpmBl23Eq
         D3E64taN8QzliiHuMFFW3H/yZuAUQvrQHgAqP1DPsMZoIvlbgnxbfgj3gTF3g7sNQxfs
         mPiLuGKBC2LG08h0EHGUILts2z/ipuiXdiw9iNEk1LJUblT8zCZ2ANuVcC1Ms8BG9RwP
         cs5fFJP2PSNOUfWDhUd398sn5YIZjOlbYMBm7iJm+3y5uCY+o7k6Jz6Aj357OfgUy2HW
         NRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789302805; x=1789907605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wocl7fHC8i0z+n+tlMoixJLCrrcWhEe8daP4QAajZFw=;
        b=CHqG6k7cQhtgFjmU2trDaoweV8MO5pFhu2HbvsMvkMVfFZHlptR0GVouP2DU2R7NQ9
         Ld0QCLV9DrWXfWpkl2JbQZvogZqnh/ia9CvlcXA8LiwG6lfJP4cPS4PRMLiJDd1vKKSM
         O622goaZELz7BwSLs8/uouyEhGHf1L4v5OZTpIN2pL72PjLweOsBgx9UGfI9WkI5/1vg
         vjhkIknOHAuW6rYHU+7UCooeP1ZMZe0Hv/gZXoGk2dtsoRgG6oeOYwBJrhV0F6VklXAu
         RuLBXQ15DrFth43FOZZX7YzlsFQqioYMxiMazRbKdnLHw0fT0QJwaro6i8TmhWOBm+Hl
         vCbA==
X-Forwarded-Encrypted: i=1; AKwUvBzlmdMxCKaljCenFOrUzfjjqUa6x/xzFQLGgGKvgOGGT0oQD1bI4BA5v+szNYlyI1arg6kL5rzuP/s=@vger.kernel.org
X-Gm-Message-State: AFuF++kEpmimZ/o5xpRda0xsJ2UVxqTqQ9EgLNSPKpLGcATto4baoJNd
	AoBG4PaFvvtDn6vvdRTg0VO33vlEAr0LtB2PI3c8Tz/8OenuF5Y5/CbOlU1Dsr7PpNmQ88zWaXt
	Azdqlh4t/gGfa48BK2ZCRre/DHAhJkEgTHUqfKjA7LULsX1EIYwccHfEeVUt0uS0=
X-Gm-Gg: AYBFou1QbvD/mP3TrpkTkeaURJRGrkZRDbhVoWQfgvE66MtmMFNFj/Krqx+vg/91oeu
	mAzBg0oLsWF0oFECgA4sfoWGPlz8zsBPIRacJTsq5k7mbAs+9Qf7z4lQozrXENbS7eVhnrK3zjL
	bg17CD7CG7sIiVH5aH99jKkuJpnOEZfs236kLfI/z141WJCqvQvhqF2M+AJ2FNf9esZ631PqwZh
	6A1OBO/hVQxhK+iE54zxfPC9jesiznnPbVmwGYqd2a5oLxxnGnujPTFjwLfid2fqgudYv5rSp7r
	yIGsyxWWwheje6YemWswI03bVzyA41uvFKhY5YOv0H7ylMQOxc8YfWkNBIH1mnHXP3iNztnbo96
	+365WEqPn2Sre95s=
X-Received: by 2002:a05:620a:4443:b0:936:eeab:307e with SMTP id af79cd13be357-93a0357e40fmr922453985a.9.1789302805160;
        Sun, 13 Sep 2026 05:33:25 -0700 (PDT)
X-Received: by 2002:a05:620a:4443:b0:936:eeab:307e with SMTP id af79cd13be357-93a0357e40fmr922450785a.9.1789302804699;
        Sun, 13 Sep 2026 05:33:24 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35bed0sm19721747f8f.32.2026.09.13.05.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:33:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        Ramona Nechita <ramona.nechita@analog.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Rishi Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org,
        linux@analog.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: iio: Use consistent indentation in the example
Date: Sun, 13 Sep 2026 14:33:20 +0200
Message-ID: <20260913123319.100212-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19300; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=RDT/FtmmxZyyNNUPEXNnhj1vIFsc1L6907cBrb+t5no=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqppgPWol163h7OVHuR/yRgILnudZ/zEiynQFXD
 s8EClqvR1uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqaYDwAKCRDBN2bmhouD
 11OtD/42uBkCKLNCAQWo2jPY6IWJ3S8O4xpcFgG0A/IjK7BFrAh7DIf5MGL0dQI+i3J0FMfhwF5
 sgWfsyJi+Q7uRbCDX1nUccvd6JzE7tTWwVbiQVKc3tLFM9oAmIuNwHqV1Wjybfke3FvSMpf0E24
 2ZV0BcLO8suOOzfu49MvxdE9dTinedAf0oehBAJFSibkjXeqxb4/94BLSL9b/UomwwDbfnTJxRE
 bG334Gm6wRJEMqpuEmqACdPquFHXupLnGgbkFBJSpr2rNuBMiseoj/isjEqWI8JIUFgtZk+Fq8q
 85LQgb7SH/hndVb3Dj2XoCvxW3C3i0grDeXqGbC2wlOP9eh1teUw627dxJmJ/uf/jjvHFJAS1TD
 iG83Ssj6QIz516zZZaqvjuWeH1K6SMc3vx/cHh8Dbj0wZMZvMk1WuSq8YuJrT0UOWF628Gb1J59
 rAoQPPN2XhyjTdz6R9MLTf+u6PgtWHbqx74F4UoO/gsNW1h7Sm2kio40UDwp26AW57/IgU/Hm9Q
 8mFOaoxKzSStT6cpm7BCcEOI7DstyaeRu09Lk1DdRl6d5pPt2/hfqlxZ2Lk22vvDHgGpv1gC4vz
 jtv+2sK45Hf1sCIlfDqDHk6S4J4tRhwDi43lFAjLX1vR1Na6zKk82UusxUiwroc6FLuq2xGZ+fs TG81+OpuyhNUgjw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8OvPMvvb51dWtWUOBteE_51fyxbMoZDc
X-Proofpoint-ORIG-GUID: 8OvPMvvb51dWtWUOBteE_51fyxbMoZDc
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa69817 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VLrvOC1cQGn0Nu_0MpAA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDE3OCBTYWx0ZWRfX0un0NxLVNG/F
 WqwhQ9UkDQitpaPGTOKkWXjW9oG7k8xJdKJmZhqdcHByXt8ax8uj3Cq+lCgkFCWv54A76wXX9ap
 56se4kBmHXTzignv+o4S42DNAveT2N4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDE3OCBTYWx0ZWRfX89Mumyu0y4S4
 QV7DzgJTc3soghzyX5g2vWbAZv6Og4RIpMq8gSKbf8bd7xt0e7E+Gd6mSbIS3OygfHY5mNTPjlw
 2j8RhSogy4nHAUnPd8iPoQUpNu7c4EKAb5b7YXhTOtqE+N0BZEzHUmdvOWpLBNek2nLkJL2QUIu
 XAmw3i+DG6+0DOG4oYROJT/0ohpzk0NWonHOjXB6f0HzBvCVgWNrhcwdA9/mBIxF2p9svo7DTKO
 Pjz6dE6BISdSJZPyxZjjdhKPjzKV48CRN37ocYymsrQtJ0RiX4TA6cnuoWCRPHdLEcdFpGrldEg
 k6N9ZpKZfY0mlE/0jF+rI04xiy58j1oJvEjtDOKAtPEY9qmW7NbgYZoebfjc9BtgXLsB3TQxmyu
 iCS3L4WZ1UL2jtxQEfvf1nOXHycI23qGhLxEKPt7Sd+hdNZWkrc1wzaH47qFSfbFuTbEd4OYbcS
 nkSiXx5YoYpdoY2V34A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130178

Correct indentation in the examples to consistent 2- or 4-spaces
indentation to fix dt-check-style warnings ("example 0
[indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
re-indenting entire example just for that is too much churn.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/iio/adc/adi,ad4080.yaml          | 36 +++++++++----------
 .../bindings/iio/adc/adi,ad4851.yaml          |  8 ++---
 .../bindings/iio/adc/adi,ad7173.yaml          |  2 +-
 .../bindings/iio/adc/adi,ad7768-1.yaml        |  6 ++--
 .../bindings/iio/adc/adi,ad7779.yaml          | 30 ++++++++--------
 .../bindings/iio/adc/adi,ade9000.yaml         | 28 +++++++--------
 .../bindings/iio/adc/maxim,max34408.yaml      | 28 +++++++--------
 .../bindings/iio/adc/nxp,lpc1850-adc.yaml     |  2 +-
 .../bindings/iio/adc/ti,ads1298.yaml          | 18 +++++-----
 .../bindings/iio/light/adux1020.yaml          |  8 ++---
 .../bindings/iio/light/amstaos,tsl2591.yaml   |  2 +-
 .../bindings/iio/light/isl29018.yaml          |  6 ++--
 .../bindings/iio/light/noa1305.yaml           |  4 +--
 .../bindings/iio/light/stk33xx.yaml           | 10 +++---
 .../bindings/iio/light/tsl2583.yaml           |  4 +--
 .../bindings/iio/light/tsl2772.yaml           | 14 ++++----
 .../bindings/iio/light/vishay,veml6030.yaml   |  8 ++---
 .../iio/pressure/infineon,dps310.yaml         | 10 +++---
 .../iio/proximity/vishay,vcnl3020.yaml        |  6 ++--
 19 files changed, 115 insertions(+), 115 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index db8467b98e67..354d73aa3e3d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -127,15 +127,15 @@ examples:
         #size-cells = <0>;
 
         adc@0 {
-          compatible = "adi,ad4080";
-          reg = <0>;
-          spi-max-frequency = <10000000>;
-          vdd33-supply = <&vdd33>;
-          vddldo-supply = <&vddldo>;
-          vrefin-supply = <&vrefin>;
-          clocks = <&cnv>;
-          clock-names = "cnv";
-          io-backends = <&iio_backend>;
+            compatible = "adi,ad4080";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            vdd33-supply = <&vdd33>;
+            vddldo-supply = <&vddldo>;
+            vrefin-supply = <&vrefin>;
+            clocks = <&cnv>;
+            clock-names = "cnv";
+            io-backends = <&iio_backend>;
         };
     };
   - |
@@ -144,15 +144,15 @@ examples:
         #size-cells = <0>;
 
         adc@0 {
-          compatible = "adi,ad4880";
-          reg = <0>, <1>;
-          spi-max-frequency = <10000000>;
-          vdd33-supply = <&vdd33>;
-          vddldo-supply = <&vddldo>;
-          vrefin-supply = <&vrefin>;
-          clocks = <&cnv>;
-          clock-names = "cnv";
-          io-backends = <&iio_backend_cha>, <&iio_backend_chb>;
+            compatible = "adi,ad4880";
+            reg = <0>, <1>;
+            spi-max-frequency = <10000000>;
+            vdd33-supply = <&vdd33>;
+            vddldo-supply = <&vddldo>;
+            vrefin-supply = <&vrefin>;
+            clocks = <&cnv>;
+            clock-names = "cnv";
+            io-backends = <&iio_backend_cha>, <&iio_backend_chb>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
index b107322e0ea3..49708ce0b230 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
@@ -142,13 +142,13 @@ examples:
             io-backends = <&iio_backend>;
 
             channel@0 {
-              reg = <0>;
-              diff-channels = <0 0>;
-              bipolar;
+                reg = <0>;
+                diff-channels = <0 0>;
+                bipolar;
             };
 
             channel@1 {
-              reg = <1>;
+                reg = <1>;
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index 62d906e24997..e178007b9a22 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -443,7 +443,7 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
 
-       adc@0 {
+      adc@0 {
         compatible = "adi,ad4111";
         reg = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index dfa2d7fa9fb3..7b72d14e104c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -238,9 +238,9 @@ examples:
             };
 
             regulators {
-              vcm_reg: vcm-output {
-                regulator-name = "ad7768-1-vcm";
-              };
+                vcm_reg: vcm-output {
+                    regulator-name = "ad7768-1-vcm";
+                };
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
index ba3f7b2bd6cf..37e25a6196e7 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
@@ -122,14 +122,14 @@ examples:
         #size-cells = <0>;
 
         adc@0 {
-          compatible = "adi,ad7779";
-          reg = <0>;
-          start-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
-          reset-gpios = <&gpio0 93 GPIO_ACTIVE_LOW>;
-          interrupt-parent = <&intc>;
-          interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
-          interrupt-names = "adc_rdy";
-          clocks = <&adc_clk>;
+            compatible = "adi,ad7779";
+            reg = <0>;
+            start-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&gpio0 93 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&intc>;
+            interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "adc_rdy";
+            clocks = <&adc_clk>;
         };
     };
 
@@ -140,13 +140,13 @@ examples:
         #size-cells = <0>;
 
         adc@0 {
-          compatible = "adi,ad7779";
-          reg = <0>;
-          start-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
-          reset-gpios = <&gpio0 93 GPIO_ACTIVE_LOW>;
-          clocks = <&adc_clk>;
-          io-backends = <&iio_backend>;
-          adi,num-lanes = <4>;
+            compatible = "adi,ad7779";
+            reg = <0>;
+            start-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&gpio0 93 GPIO_ACTIVE_LOW>;
+            clocks = <&adc_clk>;
+            io-backends = <&iio_backend>;
+            adi,num-lanes = <4>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
index 1e940e8c7297..0971a29bf372 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -89,20 +89,20 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     spi {
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-      adc@0 {
-          compatible = "adi,ade9000";
-          reg = <0>;
-          spi-max-frequency = <7000000>;
+        adc@0 {
+            compatible = "adi,ade9000";
+            reg = <0>;
+            spi-max-frequency = <7000000>;
 
-          #clock-cells = <0>;
-          reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
-          interrupts = <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FALLING>, <4 IRQ_TYPE_EDGE_FALLING>;
-          interrupt-names = "irq0", "irq1", "dready";
-          interrupt-parent = <&gpio>;
-          clocks = <&ext_clock_24576khz>;
-          vdd-supply = <&vdd_reg>;
-      };
+            #clock-cells = <0>;
+            reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+            interrupts = <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FALLING>, <4 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "irq0", "irq1", "dready";
+            interrupt-parent = <&gpio>;
+            clocks = <&ext_clock_24576khz>;
+            vdd-supply = <&vdd_reg>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
index 4cba856e8d47..bad780d1bbfb 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
@@ -118,22 +118,22 @@ examples:
         #size-cells = <0>;
 
         adc@1e {
-              compatible = "maxim,max34409";
-              reg = <0x1e>;
-              powerdown-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
-              powerdown-status-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+            compatible = "maxim,max34409";
+            reg = <0x1e>;
+            powerdown-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+            powerdown-status-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
 
-              #address-cells = <1>;
-              #size-cells = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
 
-              channel@0 {
-                  reg = <0x0>;
-                  maxim,rsense-val-micro-ohms = <5000>;
-              };
+            channel@0 {
+                reg = <0x0>;
+                maxim,rsense-val-micro-ohms = <5000>;
+            };
 
-              channel@1 {
-                  reg = <0x1>;
-                  maxim,rsense-val-micro-ohms = <10000>;
-             };
+            channel@1 {
+                reg = <0x1>;
+                maxim,rsense-val-micro-ohms = <10000>;
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,lpc1850-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,lpc1850-adc.yaml
index 70b38038a080..1e2df3dd15d1 100644
--- a/Documentation/devicetree/bindings/iio/adc/nxp,lpc1850-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,lpc1850-adc.yaml
@@ -56,6 +56,6 @@ examples:
             clocks = <&ccu1 CLK_APB3_ADC0>;
             vref-supply = <&reg_vdda>;
             resets = <&rgu 40>;
-         };
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
index 71f9f9b745cb..afcc683db149 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
@@ -65,15 +65,15 @@ examples:
         #size-cells = <0>;
 
         adc@1 {
-          reg = <1>;
-          compatible = "ti,ads1298";
-          label = "ads1298-1-ecg";
-          avdd-supply = <&reg_iso_5v_a>;
-          clocks = <&clk_ads1298>;
-          interrupt-parent = <&gpio0>;
-          interrupts = <78 IRQ_TYPE_EDGE_FALLING>;
-          spi-max-frequency = <20000000>;
-          spi-cpha;
+            reg = <1>;
+            compatible = "ti,ads1298";
+            label = "ads1298-1-ecg";
+            avdd-supply = <&reg_iso_5v_a>;
+            clocks = <&clk_ads1298>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <78 IRQ_TYPE_EDGE_FALLING>;
+            spi-max-frequency = <20000000>;
+            spi-cpha;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/light/adux1020.yaml b/Documentation/devicetree/bindings/iio/light/adux1020.yaml
index d7d14f2f1c20..83abe984a1da 100644
--- a/Documentation/devicetree/bindings/iio/light/adux1020.yaml
+++ b/Documentation/devicetree/bindings/iio/light/adux1020.yaml
@@ -40,10 +40,10 @@ examples:
         #size-cells = <0>;
 
         adux1020@64 {
-                compatible = "adi,adux1020";
-                reg = <0x64>;
-                interrupt-parent = <&msmgpio>;
-                interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+            compatible = "adi,adux1020";
+            reg = <0x64>;
+            interrupt-parent = <&msmgpio>;
+            interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
index 83b88c6a243d..512625d625a8 100644
--- a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
+++ b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
@@ -45,6 +45,6 @@ examples:
             compatible = "amstaos,tsl2591";
             reg = <0x29>;
             interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
-       };
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/light/isl29018.yaml b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
index 0ea278b07d1c..9524f0a1d195 100644
--- a/Documentation/devicetree/bindings/iio/light/isl29018.yaml
+++ b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
@@ -50,9 +50,9 @@ examples:
         #size-cells = <0>;
 
         sensor@44 {
-                compatible = "isil,isl29018";
-                reg = <0x44>;
-                interrupts-extended = <&msmgpio 61 IRQ_TYPE_LEVEL_HIGH>;
+            compatible = "isil,isl29018";
+            reg = <0x44>;
+            interrupts-extended = <&msmgpio 61 IRQ_TYPE_LEVEL_HIGH>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/light/noa1305.yaml b/Documentation/devicetree/bindings/iio/light/noa1305.yaml
index fe7bfe1adbda..e1c64c151932 100644
--- a/Documentation/devicetree/bindings/iio/light/noa1305.yaml
+++ b/Documentation/devicetree/bindings/iio/light/noa1305.yaml
@@ -39,8 +39,8 @@ examples:
         #size-cells = <0>;
 
         light@39 {
-                compatible = "onnn,noa1305";
-                reg = <0x39>;
+            compatible = "onnn,noa1305";
+            reg = <0x39>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index e4341fdced98..f071edef28cd 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -52,11 +52,11 @@ examples:
         #size-cells = <0>;
 
         stk3310@48 {
-                compatible = "sensortek,stk3310";
-                reg = <0x48>;
-                proximity-near-level = <25>;
-                interrupt-parent = <&gpio1>;
-                interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+            compatible = "sensortek,stk3310";
+            reg = <0x48>;
+            proximity-near-level = <25>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/light/tsl2583.yaml b/Documentation/devicetree/bindings/iio/light/tsl2583.yaml
index 7b92ba8cbb9f..aed4ab710e46 100644
--- a/Documentation/devicetree/bindings/iio/light/tsl2583.yaml
+++ b/Documentation/devicetree/bindings/iio/light/tsl2583.yaml
@@ -41,8 +41,8 @@ examples:
         #size-cells = <0>;
 
         light-sensor@29 {
-                compatible = "amstaos,tsl2581";
-                reg = <0x29>;
+            compatible = "amstaos,tsl2581";
+            reg = <0x29>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.yaml b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
index 9921ccaa64a0..38a3c82cb879 100644
--- a/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
+++ b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
@@ -74,13 +74,13 @@ examples:
         #size-cells = <0>;
 
         sensor@39 {
-                compatible = "amstaos,tsl2772";
-                reg = <0x39>;
-                interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
-                vdd-supply = <&pm8941_l17>;
-                vddio-supply = <&pm8941_lvs1>;
-                amstaos,proximity-diodes = <0>;
-                led-max-microamp = <100000>;
+            compatible = "amstaos,tsl2772";
+            reg = <0x39>;
+            interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&pm8941_l17>;
+            vddio-supply = <&pm8941_lvs1>;
+            amstaos,proximity-diodes = <0>;
+            led-max-microamp = <100000>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 0041e1db6838..94b3fe5cef0c 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -101,10 +101,10 @@ examples:
         #size-cells = <0>;
 
         light-sensor@10 {
-                compatible = "vishay,veml6030";
-                reg = <0x10>;
-                interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
-                vdd-supply = <&vdd>;
+            compatible = "vishay,veml6030";
+            reg = <0x10>;
+            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&vdd>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
index e5d1e6c48939..1912a1b0b4ba 100644
--- a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
@@ -45,10 +45,10 @@ examples:
         #size-cells = <0>;
 
         dps: pressure-sensor@76 {
-          compatible = "infineon,dps310";
-          reg = <0x76>;
-          #io-channel-cells = <0>;
-          vdd-supply = <&vref1>;
-          vddio-supply = <&vref2>;
+            compatible = "infineon,dps310";
+            reg = <0x76>;
+            #io-channel-cells = <0>;
+            vdd-supply = <&vref1>;
+            vddio-supply = <&vref2>;
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
index fbd3a2e32280..f84aece886ab 100644
--- a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
@@ -57,8 +57,8 @@ examples:
         #size-cells = <0>;
 
         proximity@13 {
-              compatible = "vishay,vcnl3020";
-              reg = <0x13>;
-              vishay,led-current-microamp = <200000>;
+            compatible = "vishay,vcnl3020";
+            reg = <0x13>;
+            vishay,led-current-microamp = <200000>;
         };
     };
-- 
2.53.0

