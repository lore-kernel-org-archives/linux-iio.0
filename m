Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023100.outbound.protection.outlook.com [52.101.83.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A93A8FF3;
	Wed, 21 Jan 2026 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997340; cv=fail; b=U6yjhQKVH6i+RZPy9Bd0L69YnH1lvfeRRl1AW1YUvK3s5XiQYaYH/FG2t2/LqrUrCh8skWa9JosiQvZMxmOFZ1jw+3Iej67+6Y3qyeT4PXdP2Lj0cW74icNypIy8SWIv7Fg2xKeRMDFWYf1FXlA9dzPnJWj08WAVNowiDexwKzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997340; c=relaxed/simple;
	bh=+kFtU6sCCRZEXDsUhPaP8YqfEr2sbzxMssjGW9pZL/g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iT8vtA0gmpjD/70aZEi9s76MXxBJezfTqNXua+taS1hsH98Oc/m+q8A1GcDh7qj/HqTW2hE81LQdBqyMFW/goI8PQgVCfDfzNZkp9fSpHQ4w9xFLoaJSMMtyzbjDvl4aM8dkZbePd6h5Vg+KezZNo7pApbzOvh3h28N8Ot3EXWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=h4Sp/tFX; arc=fail smtp.client-ip=52.101.83.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="h4Sp/tFX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SC7srlp2XbhmUVywSFYhBwbt2G4Z0KD3TvmLAsW61vuZ9gnYjqSjtw/VMLJZo3Txu/6nNxSRX6cSh7Sslbjx6UGmrYdpNgOUdkj2hqMdlRfGLY4l1/f4ybczyR4KC8xxsalFy8PSRHgvWtsSLcyEVehGc+agkxAk2FIM0O4SQ42fLp4IjU2ZbscVWfeYFgyxV8SB6ayFzOz3xerM++Oq6xus2jHDVDot0jkdsdvxGFZCxYs0SVgn39aEGn7qcBeRL1FJU1B45/59+8rxDXjzTUr7+2BsLuMnEat506XiR7vGcWF3gNY7/K7FFiiJEJowhB0lxJHbX+BFXHu151zLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVNh4ilej2r1XR4b/mTNeCc6NnBbPvEW9w5+PsmiPWw=;
 b=UzKxFQjDqxKZhaWS2UYGh/vPgw2RtBHbgi3UuRZP7gKQOF62Ft3/H42tH3bX/kJVad+w574yrzZKHHAc+Y5pJf8672BpqrryO9n83nBcimjGj2K6WvBQRWUgAzetKRPgjIQUF14v6pz9GC1okX1ZN6daizvEKHyWjC/2UHgoBk4mAo8uuh11qoUGIQHM4+fn62zLzacog/9U8kJE0hl1Qb+Yk7J10isSxKihGlfntgmyC6akUKquIDYe2BwMu1EoFGHBp92zfePBa/oNH9nSj62583HnE+9ChwFViq3eyskYla6zsLeV66cnc0PLxXROzpyOcLXUvQBaaZX+YoBIVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVNh4ilej2r1XR4b/mTNeCc6NnBbPvEW9w5+PsmiPWw=;
 b=h4Sp/tFX+j2rWaEVO0pzs0sZVMbL3PSFy6MZHHCzS6FzLNi25QEZ12zunuUcevRRFztBM6ihEVEZZSrElBfj34WUX+bDA1Yiv9lEitJezwaWMLbNuj4VBRlDE1GIi8T8lSMW55vq6gS1cAvzSoui9KzpuTLyutgUL3rh+m6Sn/FKDLBfGi3VgUQZfmDzLpaWkPJbhfFVVCFjbATTHk0QBsoQyFk8pDCPfCsp7Mum8HU1mobsswragzWVIzFPaDzlkv2L/XRcow9yotY58VK4ulMv9W5Ino3ElSOLhJdicp8diFIwOncph/Islsof8x8go9spTNKlUBLGcFMXAk74/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA4PR06MB8425.eurprd06.prod.outlook.com (2603:10a6:102:2a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 12:08:51 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:08:51 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 21 Jan 2026 12:08:32 +0000
Subject: [PATCH v4 3/4] iio: adc: adi-axi-dac: define supported iio-backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-ad9467-optional-backend-v4-3-18d2c0d450cc@vaisala.com>
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
In-Reply-To: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768997329; l=967;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=+kFtU6sCCRZEXDsUhPaP8YqfEr2sbzxMssjGW9pZL/g=;
 b=oy0D1BYXdAjLcngAXF7+ef8K85cf5A/qN4j5M03K1Vwg4lxkKR7EKuM2+qYDWtRDH20gRr2M3
 AQSeNmCNmA1BK7bxcQzCGgcR4wzrmgmBhnyuc9ovUGATKmBIWcYMXWP
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF00002E69.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::37) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PA4PR06MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: b262bd53-a8be-4c50-2cf6-08de58e5d76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGlFMDQvaWdiTmJLMmlyYTZ5VTJLQS91bEpua25EQXc4U1pSK2hJNHZhOTc0?=
 =?utf-8?B?eTlYdjJrMjJLZTVhYXFnbE9vTGxQeWNsajI2Sk52cFRML2UzQXI5TDg5a1JE?=
 =?utf-8?B?aXJBT0NYK2d3MmVoV1FCTUNJc0JGa3NxN2Q1SFdsNEN2NSt6NytpdUZ1YjRG?=
 =?utf-8?B?VHYvNEdPWFdnWmtMNElJeDROMGhNMVV1U3QvQmNTV2l1b1RzNXRpRFdnc2s3?=
 =?utf-8?B?QmZiOUVVYnNwVzlrOUNvWERqNTFyYXdLbHYyWXFJSlVQc2p6eXlsODUvZVZl?=
 =?utf-8?B?ZmxHNXc0NjlpMGtPMHNnWnhnczFqajBjZnVpVWJmQkUxZGxpTFlDUytVYWli?=
 =?utf-8?B?dGcwRUZscEtXRjdyK1ZFcENRRXludUxIQy9XbFN2UmdxWE02alg1RFBLTnVG?=
 =?utf-8?B?RWtaTlZNYUkzS1VhLzFZTllwUGZqeUszUzUwOUF5ZXpDSk45UE95WFdFYWtG?=
 =?utf-8?B?V2NNTFgvL093eVN6bm1PVW55Ulc5a09Vdjg3M3hSZ3BOUFByZmRpZmE5Vll2?=
 =?utf-8?B?MzYxNkRiUnRZK1FQYjRCSk8yakZSU21GR3YwakhNdUg0bjhzR1V4RFFGVTVm?=
 =?utf-8?B?RFR6ejhlZVdqZ0ZES2FRd0pvN1N0SGJKQ3J3Uno0eFliWGRpdnZlbXlWMmJy?=
 =?utf-8?B?c1hMQTRiMVFlUE9FLzBnbGlrN1JuTDJUZFpaTjFsbmhmdCtyOERhM1NNWFZL?=
 =?utf-8?B?TEprbC9hU1Z6cnhMR1NwOGJsSkxlY0oxMFJXV3k5R0hzd0QrYXBXTlc4STRN?=
 =?utf-8?B?ZkE0RlNKUlhzT3piTXVyODFRdm1uN2xIZ1ZDODJJT0RXVjBiZTNJekIvRlFU?=
 =?utf-8?B?b3hJVFRmYTBad0MyMU5ncVJSVlJNWlpFTGV0Q0lFMzIwNXRqeHJqaWxzSVNu?=
 =?utf-8?B?V24wRnpIYTdKeXNBVlFwL1BBR3pOT05uVkhaa1pEM1ZETnJqKzVDU08xSlRo?=
 =?utf-8?B?VGNTdk5KL2xSR2RTM2IvejJKUThTMUlSenFhbUhTZ3FjQUIxbE5GdU52ZWZ2?=
 =?utf-8?B?K3g2OGFQeHFJMU9aUVF5SnRQakxKazErWnNBK1A2Z213YXowY0YvdTR1bTlQ?=
 =?utf-8?B?YmNGc0laVlRzUERrR0M1dXkweEtYQ2tZNGRjVkEwSFRjcmwwaFRpVmZ4bzN1?=
 =?utf-8?B?c0k0YUt2bmk1VFRhT3lpSW1mT2ZhWGZMQVNnREpMUkdWYjBlVUJ5MnZNSlA1?=
 =?utf-8?B?NzVKLy9HSGMzdVVyckozRHpsYUN0N1N0VWpLZ3ZLSkJKcm5KcGJPam9qb1Bu?=
 =?utf-8?B?Qy9PelQ5Zjd6TldydXdxMlZDV3hQYlNPcFJZV3l4bVMyTllINHQxcnluMmFW?=
 =?utf-8?B?NHFSaVl4amsreXNrdmZOUGV3Z0xZaVFkR2ROVE9vaXBqQ2NKTVhueUlWTVI3?=
 =?utf-8?B?RkJmUHlIemFqZGtZVDRNdW5PamRiZzJiRGU0WUhsNXVqQlJVKzNGSjNKV3g5?=
 =?utf-8?B?MldGUHJTNHRPbi9JMjRHODB4R29tb1hNZmpVZlFhdmpLWE9tbVRpWlhjTUpq?=
 =?utf-8?B?T1dVN0svUXdGVFNXSm1OekJBc0xZUEE5Y240TlZiVFJ1TGlCUnBlcVZkS0R5?=
 =?utf-8?B?NDFnTFZPNVpzTGVnWlJpbmtmb0NwbUtUVGhXUUdhZWRFcm4yZ0ZIc0RSUHBU?=
 =?utf-8?B?THBTa2pWUFM0MkUzT09JNys0ZjZlSy9EaXdrUS9XQVdRakVnWjIvVnRNN3lz?=
 =?utf-8?B?eVNOWnVxRTg3UE5QMU44dXlTNjVOTVFVajkwZklyQWxCYUlBS1NtamhObHVi?=
 =?utf-8?B?c3dvL1JpaDhsdnZucThOaTd1NkxlYmRNcEtjT09zQko2MXRsTlJqVVU4Vmc2?=
 =?utf-8?B?aENqbCttS3ZZMHB2U0xzN3JKc3A0TVk3eVdIeU13N0t2NmlMU1RXc3NmQjVR?=
 =?utf-8?B?ZEIxWVBCdGNRdFUzS0xPYzNSeEJuS0ZvOW90M245V1lhVEQ1Wkhkbzg0eENm?=
 =?utf-8?B?S1FINkJKUWcrQ2hMa3Z6K1NkSG9qM1BhTmVFODR4b2w5WFp5WThSaWJOT2c3?=
 =?utf-8?B?V054UU5nM0RySWxaNE9nUzJ6eGJxU25hQXlFeGZUQVRTQ1VLRTFGQTRhcHJw?=
 =?utf-8?B?elA1L2FNRW1ZUFVuU2tYcWFZRENaTGIyc0Y0SjVUTGl1R2syMExXeEd1UUR0?=
 =?utf-8?B?d28zWTBVMDRldnNQdHhkMGpIdDc2RFhEU0o4Tkhoc3dHaVFqVkVibk5hbDhz?=
 =?utf-8?Q?PGpMuj2d54c0MPsEWrIoUSU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTJ3bEhBTnhrbDJncGUxbThJbHJZOUVnMTNIZzF6bVNvNGFBV0NBQ3JKaDg5?=
 =?utf-8?B?bGh6enV0Q1VNb2Z1cE5nOUNDVi8xcUk4STRKeW1NSWVaWnNsOFJYYVNDdk5B?=
 =?utf-8?B?emtjTDhWTEZDeXNCbUpzSnlQaE9IOGlWcS9tRTM5WldJK3ZxTGNzWUxpemRL?=
 =?utf-8?B?Z0I2eitmN0lVc2tFV2VlM0VZQTFIanVoTVRRWG9BQ21EVFFRclRtWS8xN3ZK?=
 =?utf-8?B?Vk5KYmZKOVBHTmFoQlZCQVRXNVFCUXgxMFZZb3hIRHF4YW9iRmZxSDJLQzRJ?=
 =?utf-8?B?aHhKUUJlUHJzeGIxc1daakR1d0N3a2c4NWwydC9yQ3MzZjI5WjJjbWJGeWJ0?=
 =?utf-8?B?VDZUaXI2U1Z3eVVwNzJ1dkNJejk5WDNsL1ZLdEJ3ZUFPMXlxNnIxdXQ5TFVM?=
 =?utf-8?B?U1JKckJZVWRnNHRyTHlaQVQzdUhaaVc5Myt4L1p5YncwZFFDYUdWcGZ1aDFr?=
 =?utf-8?B?QXJ2d1JnTnZ0QTl5WitoRkg3ZWtnWE43UjVoZUtHRldrMjJZZXJFc2lvMmlG?=
 =?utf-8?B?cU84QWZMMzdGRDdWamdTUVNiYlZVeU42UXNPNG9LWS9pbXMwZDBiYjBpdzZB?=
 =?utf-8?B?RGUxZis5ODBUSHJtZmtBaHBuOXBhbWU2SUFVRERsTTFlVmthai9OOVV5b3Jp?=
 =?utf-8?B?QkQxeE0xUVp4T3lwSXF3ZHlXYWJIeTlqWVl2RE1NVkd4eENEbVJhT0lxUEZj?=
 =?utf-8?B?TVBUQVRqQnVYam5sMkVIQ3dST2NkT25uYVl1L3JzQ1FNVHR2dC9mVlVzZE1n?=
 =?utf-8?B?MkFMUklSWWpGdTRNSWdnQW9zRzBOejE3MVZPalVCN05MVGxkT0k2WHVsalNE?=
 =?utf-8?B?Um8yUXY4ZStrRGtYbWZyRzE3K3BxRjZDMVJubWVseFRyK095c1lrdC9hUkR2?=
 =?utf-8?B?NkM3bVkvVE11ZXk4K2NyZ3dWZzh6ZDlEQ1pkdDlPT2NpeHNWUDloVWh5V2gr?=
 =?utf-8?B?MllyWk1XOWduMHJOL2kvY1AweEtBQ2sxeWxUa2ZYbEdicXRyOGF1a3F3UVBp?=
 =?utf-8?B?aUJQeTNFV3V1cGRsSnJ2RkZkNndUa2o0elBJNjF4VGRlVW1yVnZFSXAwQzR6?=
 =?utf-8?B?N0l2b1V1MlRaOHVSVUdSUEpZOFhxTGNqSEFzR0k3NE15dzVVQW1GYS9YYkd0?=
 =?utf-8?B?Z3pMcTZlVVR0aWozWkRIVVBXMmlqdldCaUtwL2Vrclh1RW1HNDZSQ3V6UXIy?=
 =?utf-8?B?NndzMHVuOERvVXlpS1N1UVBDQVZ2a2ZqamtwczdkOU92WE5hc1d2dm9tc3A0?=
 =?utf-8?B?ZVo4TDNMZG9VWWN0YUVaMzFZSnE3R3F0cWh6Q1RZanhCYVFDWFl6OWJiT1dP?=
 =?utf-8?B?Zkt1WDZmOXQ4TEJWVVZuRm9kd1Vpcy9MTTRQTFo5OGY2UGF4R2Q5Ky9OeWhZ?=
 =?utf-8?B?YnViMzhNZEVUK1RJcnU0WTgwaTFCOHdBVWhXZ041Q1pRVGdwOHN6VFBaQVd5?=
 =?utf-8?B?MkN0VU9ma0NGVnZncVVQbjVkb09lL055MmZqNTdCVm1WL29WdzJGZzdUSE9k?=
 =?utf-8?B?MFEyV1J6SDgvL29rTDRVQ2FNMXVKeGZjbEpmZmxvUUtZaHJueHRSdHFYZzZs?=
 =?utf-8?B?WDVxU0Z2d2JZMXd0OWlhcWg4YVY0WmxJZWRQUjIxOWRER0tzN1R5bnF4anhV?=
 =?utf-8?B?Zm5qMUtnbHZTNWMydzRQckk5cWpVUXd0aXVnVHNjdTU4R0kzN0ZydmFXb1R4?=
 =?utf-8?B?MS9LVThVRVdyME9mZjZ2ZFpzOUk2TlZtZnFyTk1vNHQ0b0RWN2NKV3haTTJp?=
 =?utf-8?B?M2ptcXBKcGZXa1VzSTJxck5KOThXNEdNbEJMcVpQYyttNC9CTGdjRG5FNmh0?=
 =?utf-8?B?NHN4OURZV1NXY0JEVVREbXNBKzlyYjMrenp4bWR5eXQyVU1mSVZZcVlmRm94?=
 =?utf-8?B?M3p4d1l2WElvYlA4TExZcStXVmxEMFNuT3A0b0poNm9WRUUzQWRGSnR4dnlp?=
 =?utf-8?B?T3RTNU9tK1NVVUtZWC9LUythalgvZ045ZWp3TzhyREN1eDdZeFNCK200amND?=
 =?utf-8?B?MHZvQWVyK3pWTFhqektoSVdBb2pQMmkvMVlTSFNGTTJEeWI3YzRjVS9jU0pn?=
 =?utf-8?B?eS9mTy8yNTdHcDhzWExUaDBJY2dFd0w4OU9CdXZMd1lacWwxUHRZRi9pLzVL?=
 =?utf-8?B?Q0wzL2hadjBLYkdFaDh3M3BBVkZaMHM1b2RZcG81dHR4c2hlS3pkWmIvMkJ1?=
 =?utf-8?B?Vi9NU0ZoNk1RZCtvUlRtekhtU0IzQnhwdUJvV1dJQjJpb3JXNjdMMnp6MGtB?=
 =?utf-8?B?ZURJTW9KZjA2Z2JVdERJMmk1TGJGUlN5M0ZLTEFhNjMxazRCTHhCMk5adzY0?=
 =?utf-8?B?dnM3MEFobG1BZDZwdWJkZGpSWnJicmVLSlY5TStXMjFJM2taVkxpNWtaS3o4?=
 =?utf-8?Q?FUY5svqmiJZmXVQM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b262bd53-a8be-4c50-2cf6-08de58e5d76b
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:08:51.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE9bFU280ZBm3LlLoEytX9S3UUCZUpRQNNtx87nogY/Vs2uYypTU7DVyS4Ipa/iRC9zBQ3wxczpZ6KwpCbgfqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB8425

Backends support buffering capability so advertise it while registering
in case a frontend makes checks for it.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/dac/adi-axi-dac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0d525272a8a8378e616fae4d0af606979d7b7716..cd06cd4587af56cd2521efcaa37c407f172e7014 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -869,11 +869,13 @@ static const struct iio_backend_ops axi_ad3552r_ops = {
 static const struct iio_backend_info axi_dac_generic = {
 	.name = "axi-dac",
 	.ops = &axi_dac_generic_ops,
+	.caps = IIO_BACKEND_CAP_BUFFERING,
 };
 
 static const struct iio_backend_info axi_ad3552r = {
 	.name = "axi-ad3552r",
 	.ops = &axi_ad3552r_ops,
+	.caps = IIO_BACKEND_CAP_BUFFERING,
 };
 
 static const struct regmap_config axi_dac_regmap_config = {

-- 
2.47.3

